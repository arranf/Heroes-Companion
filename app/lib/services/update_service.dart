import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:heroes_companion/services/heroes_service.dart';
import 'package:redux/redux.dart';

void tryUpdate(Store<AppState> store) {
  debugPrint('Try update');
  // TODO Change interface to actually throw an exception in the case we need special handling
  DataProvider.updateProvider.doesNeedUpdate().then((doesNeedUpdate) {
    if (doesNeedUpdate) {
      DataProvider.updateProvider.doUpdate()
      .then((a) => getHeroesAsync(store));
    }
  });
}
