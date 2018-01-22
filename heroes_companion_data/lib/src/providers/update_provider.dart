import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:heroes_companion_data/src/api/DTO/update_info.dart';
import 'package:heroes_companion_data/src/api/DTO/update_payload.dart';
import 'package:heroes_companion_data/src/data_provider.dart';
import 'package:heroes_companion_data/src/models/ability.dart';
import 'package:heroes_companion_data/src/models/hero.dart';
import 'package:heroes_companion_data/src/models/talent.dart';
import 'package:sqflite/sqflite.dart';
import 'package:heroes_companion_data/src/tables/ability_table.dart'
    as ability_table;
import 'package:heroes_companion_data/src/tables/hero_table.dart' as hero_table;
import 'package:heroes_companion_data/src/tables/talent_table.dart'
    as talent_table;
import 'package:heroes_companion_data/src/api/api.dart' as api;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:heroes_companion_data/src/shared_preferences_keys.dart'
    as pref_keys;

class UpdateProvider {
  Database _database;
  UpdateProvider(this._database);

  Future<bool> doesNeedUpdate() {
    return new Future.sync(() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String unparsedId = (preferences.getString(pref_keys.update_id) ?? '');
      DateTime currentId =
          unparsedId == '' ? new DateTime(1970) : DateTime.parse(unparsedId);
      UpdateInfo updateInfo = await api.getUpdateInfo();
      return updateInfo.id.isAfter(currentId);
    });
  }

  Future doUpdate() async {
    return new Future.sync(() async {
      debugPrint('Doing Update!');
      UpdatePayload updatePayload = await api.getUpdate();

      // Hero update
      await Future.wait(updatePayload.heroes.map((Hero hero) => _updateHero(hero)));
      
      // Section: Update a hero's haveassets property if any of its talents have changed
      // Group talents by heroes
      Map<int, List<Talent>> talentsByHeroId =
          groupBy(updatePayload.talents, (Talent t) => t.hero_id);
      Function equals = const UnorderedIterableEquality().equals;
      await Future.wait(talentsByHeroId.keys.map((int heroId) => _updateHaveAssets(talentsByHeroId, heroId, equals)));

      await Future.wait(updatePayload.talents.map((Talent talent) => _updateTalent(talent)));
      await Future.wait(updatePayload.abilities.map((Ability ability) => _updateAbility(ability)));

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString(
          pref_keys.update_id, updatePayload.id.toIso8601String());
      debugPrint('Update done');
    });
  }

  Future _updateHero(Hero hero) async {
    List<Map<String, dynamic>> existingHero = await _database.query(
            hero_table.table_name,
            columns: [hero_table.column_heroes_companion_hero_id],
            where: "${hero_table.column_hero_id} = ?",
            whereArgs: [hero.hero_id]);
        if (existingHero.isEmpty) {
          return _database.insert(hero_table.table_name, hero.toUpdateMap());
        } else if (existingHero.first[hero_table.column_sha3_256] != hero.sha3_256) {
          return _database.update(hero_table.table_name, hero.toUpdateMap(),
              where: "${hero_table.column_heroes_companion_hero_id} = ?",
              whereArgs: [
                existingHero.first[hero_table.column_heroes_companion_hero_id]
              ]);
        }
  }

  Future _updateHaveAssets(Map<int, List<Talent>> talentsByHeroId, int heroId, Function equals) async {
    List<Talent> talents = talentsByHeroId[heroId];
        List<Talent> existingTalents =
            await DataProvider.talentProvider.getTalentsForHero(heroId);
        if (existingTalents != null &&
            existingTalents.isNotEmpty &&
            !equals(talents.map((t) => t.sha3_256), existingTalents.map((t) =>  t.sha3_256))
            ) {
          // Set hero last modified as now andd assume we don't have images
          // TODO handle talents images on a talent by talent basis
          await _database.update(
              hero_table.table_name,
              {
                hero_table.column_modified_date:
                    new DateTime.now().toIso8601String(),
                hero_table.column_have_assets: 0
              },
              where: "${hero_table.column_hero_id} = ?",
              whereArgs: [heroId]);
        }
  }

  Future _updateTalent(Talent talent) async {
    List<Map<String, dynamic>> existingTalent = await _database.query(
            talent_table.table_name,
            columns: [talent_table.column_id],
            where:
                "${talent_table.column_tool_tip_id} = ? AND ${talent_table.column_hero_id} = ?",
            whereArgs: [talent.tool_tip_id, talent.hero_id]);
        if (existingTalent.isEmpty) {
          await _database.insert(talent_table.table_name, talent.toUpdateMap());
        } else if (existingTalent.first[talent_table.column_sha3_256] != talent.sha3_256) {
          await _database.update(talent_table.table_name, talent.toUpdateMap(),
              where: "${talent_table.column_id} = ?",
              whereArgs: [existingTalent.first[talent_table.column_id]]);
        }
  }

  Future _updateAbility(Ability ability) async {
    List<Map<String, dynamic>> existingAbility = await _database.query(
            ability_table.table_name,
            columns: [ability_table.column_id],
            where: "${ability_table.column_ability_id} = ?",
            whereArgs: [ability.ability_id]);
        if (existingAbility.isEmpty) {
          await _database.insert(
              ability_table.table_name, ability.toUpdateMap());
        } else if (existingAbility.first[ability_table.column_sha3_256] != ability.sha3_256)  {
          await _database.update(
              ability_table.table_name, ability.toUpdateMap(),
              where: "${ability_table.column_id} = ?",
              whereArgs: [
                existingAbility.first[ability_table.column_ability_id]
              ]);
        }
  }
}
