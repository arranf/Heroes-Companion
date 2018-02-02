import 'dart:async';

import 'package:heroes_companion_data/src/api/DTO/patch_data.dart';
import 'package:heroes_companion_data/src/api/api.dart' as api;
import 'package:heroes_companion_data/src/models/patch.dart';

class PatchProvider {
  Future<List<Patch>> getPatches() async {
    // TODO Future sync
    print('Getting patches');
    List<PatchData> patches;
    try {
      patches = await api.getPatchData();
    } catch (e) {
      throw e;
    }
    if (patches == null) {
      throw new Exception('API call to fetch patch data failed');
    }
    print(patches[0]);
    return patches.map((pd) => new Patch.from(pd));
  }
}
