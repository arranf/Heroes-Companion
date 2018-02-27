import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';

final heroStatisticialBuildsLoadingReducer = combineTypedReducers<bool>([
  new ReducerBinding<bool, StatisticalHeroBuildStartLoadingAction>(
      _setNotLoaded),
  new ReducerBinding<bool, FetchStatisticalHeroBuildSucceededAction>(
      _setLoaded),
  new ReducerBinding<bool, FetchStatisticalHeroBuildFailedAction>(_setLoaded),
]);

bool _setLoaded(bool state, action) {
  return false;
}

bool _setNotLoaded(bool state, action) {
  return true;
}
