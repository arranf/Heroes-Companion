import 'dart:async';

import 'package:heroes_companion_data/src/models/playable_map.dart';
import 'package:sqflite/sqflite.dart';
import 'package:heroes_companion_data/src/tables/map_table.dart'
    as map_table;

class MapProvider {
  Database _database;
  MapProvider(this._database);

  Future<List<PlayableMap>> getMaps() {
    return new Future.sync(() async {
      List<Map> maps = await _database.query(
        map_table.table_name,
        columns: null
      );
      if (maps.isNotEmpty) {
        return maps.map((Map m) => new PlayableMap.fromMap(m)).toList();
      }
      return null;
  });
  }
}