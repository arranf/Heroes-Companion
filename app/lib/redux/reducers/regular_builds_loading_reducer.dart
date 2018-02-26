import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';

final regularBuildsLoadingReducer = combineTypedReducers<bool>([
  new ReducerBinding<bool, FetchHeroBuildsStartLoadingAction>(_setNotLoaded),
  new ReducerBinding<bool, FetchHeroBuildsFailedAction>(_setLoaded),
  new ReducerBinding<bool, FetchStatisticalHeroBuildFailedAction>(_setLoaded),
]);

bool _setLoaded(bool state, action) {
  return false;
}

bool _setNotLoaded(bool state, action) {
  return true;
}