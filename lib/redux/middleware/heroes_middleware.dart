import 'package:redux/redux.dart';
import 'package:flutter/foundation.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion/redux/actions/actions.dart';

List<Middleware<AppState>> createHeroMiddleware() {
  final loadHeroes = _createLoadHeroes();

  return combineTypedMiddleware([
    new MiddlewareBinding<AppState, LoadHeroAction>(loadHeroes)
  ]);
}

Middleware<AppState> _createLoadHeroes() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    try {
      List<Hero> heroes = await DataProvider.heroProvider.getHeroes();
      store.dispatch(new HeroesLoadedAction(heroes));
    } catch (e) {
      store.dispatch(new HeroesNotLoadedAction());
    }
    next(action);
  };
}