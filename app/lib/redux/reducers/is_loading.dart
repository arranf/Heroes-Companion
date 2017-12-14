import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';
import 'package:flutter/foundation.dart';

final loadingReducer = combineTypedReducers<bool>([
  new ReducerBinding<bool, HeroesLoadedAction>(_setLoaded),
  new ReducerBinding<bool, HeroesNotLoadedAction>(_setLoaded),
  new ReducerBinding<bool, StartLoadingAction>(_setNotLoaded),
  new ReducerBinding<bool, BuildInfoLoadedAction>(_setLoaded),
  new ReducerBinding<bool, BuildInfoNotLoadedAction>(_setLoaded),
]);

bool _setLoaded(bool state, action) {
  return false;
}

bool _setNotLoaded(bool state, action) {
  return true;
}