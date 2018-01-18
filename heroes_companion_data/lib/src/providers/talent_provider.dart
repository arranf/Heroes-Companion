import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:heroes_companion_data/src/models/talent.dart';
import 'package:heroes_companion_data/src/tables/talent_table.dart'
    as talent_table;

class TalentProvider {
  Database _database;
  TalentProvider(this._database);

  Future<List<Talent>> getTalentsForHero(int hero_id) {
    return new Future.sync(() async {
        List<Map> maps = await _database.query(
        talent_table.table_name,
        columns: null,
        where: "${talent_table.column_hero_id} = ?",
        whereArgs: [hero_id],
        orderBy:
            "${talent_table.column_level} ASC, ${talent_table.column_sort_order} ASC",
      );
      if (maps.length > 0) {
        return new List.generate(
            maps.length, (int i) => new Talent.fromMap(maps[i]));
      }
      return null;
    });
  }
}
