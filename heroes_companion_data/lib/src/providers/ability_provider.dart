import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:heroes_companion_data/src/models/ability.dart';
import 'package:heroes_companion_data/src/tables/ability_table.dart'
    as ability_table;

class AbilityProvider {
  Database _database;
  AbilityProvider(this._database);

  Future<List<Ability>> getAbilitiesForHero(int hero_id) async {
    List<Map> maps = await _database.query(
      ability_table.table_name,
      columns: null,
      where: "${ability_table.column_hero_id} = ?",
      whereArgs: [hero_id],
      orderBy: "${ability_table.column_name} ASC",
    );
    if (maps.length > 0) {
      return new List.generate(
          maps.length, (int i) => new Ability.fromMap(maps[i]));
    }
    return null;
  }
}
