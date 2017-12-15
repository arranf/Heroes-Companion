import 'package:hots_dog_api/hots_dog_api.dart';
import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';

final winRatesReducer = combineTypedReducers<WinRates>([
  new ReducerBinding<WinRates, FetchWinRatesSucceededAction>(_setLoadedWinRates),
  new ReducerBinding<WinRates, FetchWinRatesFailedAction>(_setNoWinRates)
]);

WinRates _setLoadedWinRates(WinRates winRates, FetchWinRatesSucceededAction action) {
  return action.winRates;
}

WinRates _setNoWinRates(WinRates winRates, FetchWinRatesFailedAction action) {
  return null;
}