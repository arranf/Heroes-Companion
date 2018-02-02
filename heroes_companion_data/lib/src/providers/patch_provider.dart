import 'dart:async';

import 'package:heroes_companion_data/src/api/DTO/patch_data.dart';
import 'package:heroes_companion_data/src/api/api.dart' as api;
import 'package:heroes_companion_data/src/models/patch.dart';

class PatchProvider {
  Future<List<Patch>> getPatches() async {
    // TODO Future sync
    print('Getting patches');
    List<PatchData> patches = await api.getPatchData();
    if (patches == null) {
      throw new Exception('API call to fetch patch data failed');
    }
    return patches.map((PatchData pd) => new Patch.from(pd)).toList();
  }
}
