import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';

final heroStatisticialBuildsLoadingReducer = combineReducers<bool>([
  new TypedReducer<bool, StatisticalHeroBuildStartLoadingAction>(_setNotLoaded),
  new TypedReducer<bool, FetchStatisticalHeroBuildSucceededAction>(_setLoaded),
  new TypedReducer<bool, FetchStatisticalHeroBuildFailedAction>(_setLoaded),
]);

bool _setLoaded(bool state, action) {
  return false;
}

bool _setNotLoaded(bool state, action) {
  return true;
}
