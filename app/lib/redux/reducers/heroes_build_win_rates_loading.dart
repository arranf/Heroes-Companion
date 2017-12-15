import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';
import 'package:flutter/foundation.dart';

final heroesBuildWinRatesloadingReducer = combineTypedReducers<bool>([
  new ReducerBinding<bool, BuildWinRatesStartLoadingAction>(_setNotLoaded),
  new ReducerBinding<bool, FetchBuildWinRatesSucceededAction>(_setLoaded),
  new ReducerBinding<bool, FetchBuildWinRatesFailedAction>(_setLoaded),
]);

bool _setLoaded(bool state, action) {
  return false;
}

bool _setNotLoaded(bool state, action) {
  return true;
}
