import 'package:hots_dog_api/hots_dog_api.dart';
import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';

final winRatesReducer = combineTypedReducers<Map<String, WinRates>>([
  new ReducerBinding<Map<String, WinRates>, FetchWinRatesSucceededAction>(
      _setWinRatesSucceeded),
  new ReducerBinding<Map<String, WinRates>, FetchWinRatesFailedAction>(
      _setWinRatesFailed)
]);

Map<String, WinRates> _setWinRatesSucceeded(
    Map<String, WinRates> winRates, FetchWinRatesSucceededAction action) {
  Map<String, WinRates> newWinRates =
      new Map<String, WinRates>.from(winRates ?? new Map<String, WinRates>());
  newWinRates[action.buildNumber] = action.winRates;
  return newWinRates;
}

Map<String, WinRates> _setWinRatesFailed(
    Map<String, WinRates> winRates, FetchWinRatesFailedAction action) {
  return winRates;
}
