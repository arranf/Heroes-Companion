import 'dart:async';

import 'package:heroes_companion/redux/actions/actions.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:heroes_companion/services/heroes_service.dart';
import 'package:redux/redux.dart';

Future tryUpdate(Store<AppState> store) {
  return new Future.sync(() {
    store.dispatch(new StartUpdatingAction());
    return DataProvider.updateProvider.doesNeedUpdate().then((doesNeedUpdate) {
      if (doesNeedUpdate) {
        return DataProvider.updateProvider
            .doUpdate()
            .then((a) => getHeroesAsync(store))
            .then((b) => store.dispatch(new StopUpdatingAction()));
      } else {
        store.dispatch(new StopUpdatingAction());
      }
    });
  });
}
