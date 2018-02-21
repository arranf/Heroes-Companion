import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';

final loadingReducer = combineTypedReducers<bool>([
  new ReducerBinding<bool, StartLoadingAction>(_setNotLoaded),
  new ReducerBinding<bool, FetchHeroesSucceededAction>(_setLoaded),
  new ReducerBinding<bool, FetchHeroesFailedAction>(_setLoaded),
  new ReducerBinding<bool, FetchPatchesSucceededAction>(_setLoaded),
  new ReducerBinding<bool, FetchPatchesFailedAction>(_setLoaded),
  new ReducerBinding<bool, FetchWinRatesSucceededAction>(_setLoaded),
  new ReducerBinding<bool, FetchWinRatesFailedAction>(_setLoaded),
  new ReducerBinding<bool, FetchMapsSucceededAction>(_setLoaded),
  new ReducerBinding<bool, FetchMapsFailedAction>(_setLoaded),  
]);

bool _setLoaded(bool state, action) {
  return false;
}

bool _setNotLoaded(bool state, action) {
  return true;
}
