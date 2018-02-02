import 'dart:async';

import 'package:heroes_companion_data/src/api/DTO/patch_data.dart';
import 'package:heroes_companion_data/src/api/api.dart' as api;
import 'package:heroes_companion_data/src/models/patch.dart';
import 'package:heroes_companion_data/src/tables/patch_table.dart' as table;
import 'package:sqflite/sqflite.dart';

class PatchProvider {
  Database _database;
  PatchProvider(this._database);

  Future<List<Patch>> getPatches() async {
    print('Getting patches');
    List<Map<String, dynamic>> results = await _database.query(
        table.table_name,
        columns: null
    );
    print('Got ${results.length} patches');
    return results.map((m) => new Patch.fromMap(m)).toList();
  }

  Future<List<Patch>> fetchPatches() {
    return new Future.sync(() async {
      print('Fetching patches');
      List<PatchData> patchDatas = await api.getPatchData();
      if (patchDatas == null) {
        throw new Exception('API call to fetch patch data failed');
      }

      List<Map<String, dynamic>> existingPatchData  = await _database.query(
        table.table_name,
        columns: [table.column_full_version]
      );
      List<String> patchIds = existingPatchData.map((p) => p[table.column_full_version]).toList();

      List<Patch> patches = patchDatas.map((PatchData pd) => new Patch.from(pd)).toList();

      // Insert unseen patches
      Batch batch = _database.batch();
      patches
        .where((Patch p) => !patchIds.contains(p.fullVersion))
        .forEach((p) =>  batch.insert(table.table_name, p.toMap()));
      batch.commit();
      print('Added ${patches.where((Patch p) => !patchIds.contains(p.fullVersion)).length} new patches');
      return patches;
    });    
  }

  
}
