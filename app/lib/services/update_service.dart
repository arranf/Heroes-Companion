import 'dart:async';

import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:heroes_companion/services/heroes_service.dart';
import 'package:redux/redux.dart';

Future tryUpdate(Store<AppState> store) async {
  return new Future.sync(() {
    return DataProvider.updateProvider.doesNeedUpdate().then((doesNeedUpdate) {
      if (doesNeedUpdate) {
        DataProvider.updateProvider
            .doUpdate()
            .then((a) => getHeroesAsync(store));
      }
    });
  });
}
