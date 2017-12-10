import 'dart:async';

import 'package:redux/redux.dart';

import 'package:hots_dog_api/hots_dog_api.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion/redux/actions/actions.dart';



List<Middleware<AppState>> createGameInfoMiddleware() {
  final loadGameInfo = _createLoadGameInfo();

  return combineTypedMiddleware([
    new MiddlewareBinding<AppState, LoadGameInfoAction>(loadGameInfo)
  ]);
}

Middleware<AppState> _createLoadGameInfo() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    try {
      GameInfo gameInfo = await getGameInfo();
      store.dispatch(new GameInfoLoadedAction(gameInfo));
    } catch (e) {
      store.dispatch(new GameInfoNotLoadedAction());
    }
    next(action);
  };
}