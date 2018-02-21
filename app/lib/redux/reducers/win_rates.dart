import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';

final winRatesReducer = combineTypedReducers<Map<String, List<HeroWinRate>>>([
  new ReducerBinding<Map<String, List<HeroWinRate>>, FetchWinRatesSucceededAction>(
      _setWinRatesSucceeded),
  new ReducerBinding<Map<String, List<HeroWinRate>>, FetchWinRatesFailedAction>(
      _setWinRatesFailed),
  new ReducerBinding<Map<String, List<HeroWinRate>>, DataSourceChangedAction>(_clearWinRates),
]);

Map<String, List<HeroWinRate>> _setWinRatesSucceeded(
    Map<String, List<HeroWinRate>> winRates, FetchWinRatesSucceededAction action) {
  Map<String, List<HeroWinRate>> newWinRates =
      new Map<String, List<HeroWinRate>>.from(winRates ?? new Map<String, List<HeroWinRate>>());
  newWinRates[action.buildNumber] = action.winRates;
  return newWinRates;
}

Map<String, List<HeroWinRate>> _setWinRatesFailed(
    Map<String, List<HeroWinRate>> winRates, FetchWinRatesFailedAction action) {
  return winRates;
}

Map<String, List<HeroWinRate>> _clearWinRates(Map<String, List<HeroWinRate>> winRates, DataSourceChangedAction action) {
  return new Map<String, List<HeroWinRate>>();
}
