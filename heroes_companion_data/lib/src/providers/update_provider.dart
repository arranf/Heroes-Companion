import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:heroes_companion_data/src/api/DTO/update_info.dart';
import 'package:heroes_companion_data/src/api/DTO/update_payload.dart';
import 'package:heroes_companion_data/src/data_provider.dart';
import 'package:heroes_companion_data/src/models/ability.dart';
import 'package:heroes_companion_data/src/models/hero.dart';
import 'package:heroes_companion_data/src/models/settings.dart';
import 'package:heroes_companion_data/src/models/talent.dart';
import 'package:sqflite/sqflite.dart';
import 'package:heroes_companion_data/src/tables/ability_table.dart'
    as ability_table;
import 'package:heroes_companion_data/src/tables/hero_table.dart' as hero_table;
import 'package:heroes_companion_data/src/tables/talent_table.dart'
    as talent_table;
import 'package:heroes_companion_data/src/api/api.dart' as api;

class UpdateProvider {
  Database _database;
  UpdateProvider(this._database);

  Future<bool> doesNeedUpdate() {
    return new Future.sync(() async {
      Settings settings = await DataProvider.settingsProvider.readSettings();
      UpdateInfo updateInfo = await api.getUpdateInfo();
      return updateInfo.id.isAfter(settings.currentUpdateOriginTime);
    });
  }

  Future doUpdate() {
    return new Future.sync(() async {
      debugPrint('Doing Update!');
      UpdatePayload updatePayload = await api.getUpdate();

      Batch batch = _database.batch();

      // Hero Update
      List<Map<String, dynamic>> existingHeroes =
          await _database.query(hero_table.table_name, columns: [
        hero_table.column_hero_id,
        hero_table.column_sha3_256,
        hero_table.column_heroes_companion_hero_id
      ]);
      updatePayload.heroes.forEach((Hero hero) {
        Map<String, dynamic> existingHero = existingHeroes.firstWhere(
            (h) => h[hero_table.column_hero_id] == hero.hero_id,
            orElse: () => {});
        _updateHero(hero, existingHero, batch);
      });

      // TODO Check if asset has been bundled and mark it as have asset
      // Talent update
      List<Map<String, dynamic>> existingTalents =
          await _database.query(talent_table.table_name, columns: [
        talent_table.column_id,
        talent_table.column_hero_id,
        talent_table.column_tool_tip_id,
        talent_table.column_talent_tree_id,
        talent_table.column_sha3_256,
        talent_table.column_have_asset
      ]);

      Set<int> heroesToMarkToUpdate = new Set();
      // Start a set of all the talents that already exist, we'll remove the ones that we update from this list
      Set<int> talentsToDelete = existingTalents.map((m) => m[talent_table.column_id] as int).toSet();

      updatePayload.talents.forEach((Talent talent) {
        Map<String, dynamic> existingTalent = existingTalents.firstWhere(
            (t) =>
                t[talent_table.column_tool_tip_id] == talent.tool_tip_id &&
                t[talent_table.column_talent_tree_id] == talent.talent_tree_id &&
                t[talent_table.column_hero_id] == talent.hero_id,
            orElse: () => {});

        // Collect heroes who have had talents updated
        int heroId = _updateTalent(talent, existingTalent, batch);

        // Remove existing talents that should still exist from the talents to delete set
        if (existingTalent != null && existingTalent.isNotEmpty) {
          talentsToDelete.remove(existingTalent[talent_table.column_id] as int);
        }
        heroesToMarkToUpdate.add(heroId);
      });

      // Delete old talents that are no longer part of the game
      batch.delete(
        talent_table.table_name, 
        where: "${talent_table.column_id} in (?)", 
        whereArgs: [talentsToDelete.where((a) => a != null).join(',')]
      );

      // Mark heroes as modified if they've had talents changed
      batch.update(
          hero_table.table_name,
          {
            hero_table.column_modified_date:
                updatePayload.patch_date.toIso8601String()
          },
          where: "${hero_table.column_hero_id} IN (?)",
          whereArgs: [heroesToMarkToUpdate.where((a) => a != null).join(',')]);
      
      // TODO Mark heroes as modified when their abilities change and delete old abilities

      // Ability update
      List<Map<String, dynamic>> abilities =
          await _database.query(ability_table.table_name, columns: [
        ability_table.column_id,
        ability_table.column_ability_id,
        ability_table.column_sha3_256
      ]);

      updatePayload.abilities.forEach((Ability ability) {
        Map<String, dynamic> existingAbilities = abilities.firstWhere(
            (a) => a[ability_table.column_ability_id] == ability.ability_id,
            orElse: () => {});
        _updateAbility(ability, existingAbilities, batch);
      });

      await batch.commit(noResult: false);

      Settings settings = await DataProvider.settingsProvider.readSettings();
      DataProvider.settingsProvider.writeSettings(settings.copyWith(
          currentUpdateOriginTime: updatePayload.id,
          updatePatch: updatePayload.patch));
      debugPrint('Update done');
    });
  }

  void _updateHero(Hero hero, Map<String, dynamic> existingHero, Batch batch) {
    if (existingHero == null ||
        !existingHero.containsKey(hero_table.column_heroes_companion_hero_id) ||
        existingHero[hero_table.column_heroes_companion_hero_id] == null) {
      batch.insert(hero_table.table_name, hero.toUpdateMap());
    } else if (!existingHero.containsKey(hero_table.column_sha3_256) ||
        existingHero[hero_table.column_sha3_256] != hero.sha3_256) {
      batch.update(hero_table.table_name, hero.toUpdateMap(),
          where: "${hero_table.column_heroes_companion_hero_id} = ?",
          whereArgs: [
            existingHero[hero_table.column_heroes_companion_hero_id]
          ]);
    }
  }

  // Given a talent from the update payload, and an existing talent row if one is found. This function either:
  //   a) Inserts a new row in table for the talent 
  //   b) Updates the existing row and marks the row as not having the image asset in the apk bundle
  //   c) Updates the existing row without changing the asset bundle boolean
  ///  d) Doesn't change anything (talent already exists and sha3 hashes match)
  int _updateTalent(
      Talent talent, Map<String, dynamic> existingTalent, Batch batch) {
    // Doesn't exist, insert
    if (existingTalent == null || existingTalent.isEmpty) {
      Map<String, dynamic> updateMap = talent.toUpdateMap();
      updateMap[talent_table.column_have_asset] = false;
      batch.insert(talent_table.table_name, talent.toUpdateMap());
      return talent.hero_id;
    }
    // Changed and new image needs to be fetched
    else if ((!existingTalent.containsKey(talent_table.column_sha3_256) ||
        existingTalent[talent_table.column_sha3_256] != talent.sha3_256) &&
            existingTalent[talent_table.column_icon_file_name] !=
                talent.icon_file_name) {
      Map<String, dynamic> updateMap = talent.toUpdateMap();
      updateMap[talent_table.column_have_asset] = false;
      batch.update(talent_table.table_name, updateMap,
          where: "${talent_table.column_id} = ?",
          whereArgs: [existingTalent[talent_table.column_id]]);
      return talent.hero_id;
    }
    // Changed, no known new image
    else if (!existingTalent.containsKey(talent_table.column_sha3_256) ||
        existingTalent[talent_table.column_sha3_256] != talent.sha3_256) {
      batch.update(talent_table.table_name, talent.toUpdateMap(),
          where: "${talent_table.column_id} = ?",
          whereArgs: [existingTalent[talent_table.column_id]]);
      return talent.hero_id;
    }
    return null;
  }

  void _updateAbility(
      Ability ability, Map<String, dynamic> existingAbility, Batch batch) {
    if (existingAbility == null ||
        !existingAbility.containsKey(ability_table.column_id)) {
      batch.insert(ability_table.table_name, ability.toUpdateMap());
    } else if (!existingAbility.containsKey(ability_table.column_sha3_256) ||
        existingAbility[ability_table.column_sha3_256] != ability.sha3_256) {
      batch.update(ability_table.table_name, ability.toUpdateMap(),
          where: "${ability_table.column_id} = ?",
          whereArgs: [existingAbility[ability_table.column_ability_id]]);
    }
  }
}
