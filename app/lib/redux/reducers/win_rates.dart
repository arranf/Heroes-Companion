import 'package:hots_dog_api/hots_dog_api.dart';
import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';

final winRatesReducer = combineTypedReducers<WinRates>([
  new ReducerBinding<WinRates, WinRatesLoadedAction>(_setLoadedWinRates),
  new ReducerBinding<WinRates, WinRatesNotLoadedAction>(_setNoWinRates)
]);

WinRates _setLoadedWinRates(WinRates winRates, WinRatesLoadedAction action) {
  return action.winRates;
}

WinRates _setNoWinRates(WinRates winRates, WinRatesNotLoadedAction action) {
  return null;
}