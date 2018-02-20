import 'dart:async';

import 'package:flutter/material.dart';
import 'package:heroes_companion/global_keys.dart';
import 'package:heroes_companion/redux/actions/actions.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:heroes_companion/services/heroes_service.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future tryUpdate(Store<AppState> store) {
  return new Future.sync(() {
    return DataProvider.updateProvider.doesNeedUpdate().then((doesNeedUpdate) {
      if (doesNeedUpdate) {
        store.dispatch(new StartUpdatingAction());
        return DataProvider.updateProvider
            .doUpdate()
            .then((a) => getHeroesAsync(store))
            .then((b) => store.dispatch(new StopUpdatingAction()))
            .then((c) => SharedPreferences.getInstance())
            .then((preferences) async {
              Settings settings = await DataProvider.settingsProvider.readSettings();
             homeScaffoldKey.currentState?.showSnackBar(
                new SnackBar(
                    content: new Text(
                        'Updated for patch ${preferences.getString(settings.updatePatch)}'))
             );
            });
      } else {
        store.dispatch(new StopUpdatingAction());
      }
    });
  });
}
