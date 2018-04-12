import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:heroes_companion/redux/actions/actions.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion/services/exception_service.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:redux/redux.dart';

void getHeroes(Store<AppState> store) {
  store.dispatch(new StartLoadingAction());
  DataProvider.heroProvider
      .updateHeroRotations()
      .catchError((e) {
        new ExceptionService().reportError(e); // Future completes with 42.
      })
      .then((a) => DataProvider.heroProvider.getHeroes())
      .then((List<Hero> heroes) =>
          store.dispatch(new FetchHeroesSucceededAction(heroes)))
      .catchError((e) {
        new ExceptionService().reportError(e);
        store.dispatch(new FetchHeroesFailedAction());
      });
}

Future getHeroesAsync(Store<AppState> store,
    {bool isForceRefreshRotation = false}) {
  return DataProvider.heroProvider
      .updateHeroRotations(isForced: isForceRefreshRotation)
      .then((a) => DataProvider.heroProvider.getHeroes())
      .then((List<Hero> heroes) {
    if (heroes != null) {
      store.dispatch(new FetchHeroesSucceededAction(heroes));
    } else {
      store.dispatch(new FetchHeroesFailedAction());
    }
  }).catchError((e) {
    debugPrint(e.toString());
    store.dispatch(new FetchHeroesFailedAction());
  });
}

void setFavorite(Store<AppState> store, Hero hero) {
  // TODO make the store immutable
  hero.is_favorite = true;
  DataProvider.heroProvider
      .update(hero)
      .then((int i) => store.dispatch(new UpdateHeroAction(hero)));
}

void unFavorite(Store<AppState> store, Hero hero) {
  // TODO make the store immutable
  hero.is_favorite = false;
  DataProvider.heroProvider
      .update(hero)
      .then((int i) => store.dispatch(new UpdateHeroAction(hero)));
}
