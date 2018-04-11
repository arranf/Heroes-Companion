import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';

final loadingReducer = combineReducers<bool>([
  new TypedReducer<bool, StartLoadingAction>(_setNotLoaded),
  new TypedReducer<bool, FetchHeroesSucceededAction>(_setLoaded),
  new TypedReducer<bool, FetchHeroesFailedAction>(_setLoaded),
  new TypedReducer<bool, FetchPatchesSucceededAction>(_setLoaded),
  new TypedReducer<bool, FetchPatchesFailedAction>(_setLoaded),
  new TypedReducer<bool, FetchWinRatesSucceededAction>(_setLoaded),
  new TypedReducer<bool, FetchWinRatesFailedAction>(_setLoaded),
  new TypedReducer<bool, FetchMapsSucceededAction>(_setLoaded),
  new TypedReducer<bool, FetchMapsFailedAction>(_setLoaded),
]);

bool _setLoaded(bool state, action) {
  return false;
}

bool _setNotLoaded(bool state, action) {
  return true;
}
