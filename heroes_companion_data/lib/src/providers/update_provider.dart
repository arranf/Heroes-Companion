import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:heroes_companion_data/src/api/DTO/update_info.dart';
import 'package:heroes_companion_data/src/api/DTO/update_payload.dart';
import 'package:sqflite/sqflite.dart';
import 'package:heroes_companion_data/src/tables/ability_table.dart' as ability_table;
import 'package:heroes_companion_data/src/tables/hero_table.dart' as hero_table;
import 'package:heroes_companion_data/src/tables/talent_table.dart' as talent_table;
import 'package:heroes_companion_data/src/api/api.dart' as api;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:heroes_companion_data/src/shared_preferences_keys.dart' as pref_keys;

class UpdateProvider {
  Database _database;
  UpdateProvider(this._database);

  Future<bool> doesNeedUpdate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String unparsedId = (preferences.getString(pref_keys.update_id) ?? '');
    DateTime currentId = unparsedId == '' ? new DateTime(1970) : DateTime.parse(unparsedId);
    UpdateInfo updateInfo = await api.getUpdateInfo();
    return updateInfo.id.isAfter(currentId);
  }

  Future doUpdate() async {
    UpdatePayload updatePayload = await api.getUpdate();
    
    // Hero Update
    List<Map> heroUpdateMaps = updatePayload.heroes.map((h) => h.toUpdateMap()).toList();
    heroUpdateMaps.forEach((m) async {
      Hero existingHero = updatePayload.heroes.firstWhere((hero) => hero.hero_id == m[hero_table.column_hero_id]);
      await _database.update(hero_table.table_name, m, 
      where: "${hero_table.column_heroes_companion_hero_id} = ?", whereArgs: [existingHero.heroes_companion_hero_id] );
    });

    // Talent Update
    List<Map> talentUpdateMaps = updatePayload.talents.map((t) => t.toUpdateMap()).toList();
    talentUpdateMaps.forEach((m) async {
      Talent existingTalent = updatePayload.talents
        .firstWhere((talent) => talent.tool_tip_id == m[talent_table.column_tool_tip_id] && 
          talent.hero_id == m[talent_table.column_hero_id]);
      await _database.update(talent_table.table_name, m, 
      where: "${talent_table.column_id} = ?", whereArgs: [existingTalent.id] );
    });

    // Ability Update
    List<Map> abilityUpdateMaps = updatePayload.abilities.map((a) => a.toUpdateMap()).toList();
    abilityUpdateMaps.forEach((m) async {
      Ability existingAbility = updatePayload.abilities.firstWhere((ability) => ability.ability_id == m[ability_table.column_ability_id]);
      await _database.update(ability_table.table_name, m, 
      where: "${ability_table.column_id} = ?", whereArgs: [existingAbility.id] );
    });

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(pref_keys.update_id, updatePayload.id.toIso8601String());
  }
}