import 'package:hots_dog_api/hots_dog_api.dart';
import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';

final heroesBuildWinRatesReducer =
    combineTypedReducers<Map<int, Map<String, BuildWinRates>>>([
  new ReducerBinding<Map<int, Map<String, BuildWinRates>>,
      FetchBuildWinRatesSucceededAction>(_succeed),
  new ReducerBinding<Map<int, Map<String, BuildWinRates>>,
      FetchBuildWinRatesFailedAction>(_fail)
]);

Map<int, Map<String, BuildWinRates>> _succeed(
    Map<int, Map<String, BuildWinRates>> winRates,
    FetchBuildWinRatesSucceededAction action) {
  Map<int, Map<String, BuildWinRates>> newWinRates =
      new Map<int, Map<String, BuildWinRates>>.from(
          winRates ?? new Map<int, Map<String, BuildWinRates>>());
  newWinRates[action.heroCompanionId] = new Map<String, BuildWinRates>.from(
      newWinRates[action.heroCompanionId] ?? new Map<String, BuildWinRates>());
  newWinRates[action.heroCompanionId][action.buildNumber] =
      action.buildWinRates;
  return newWinRates;
}

Map<int, Map<String, BuildWinRates>> _fail(
    Map<int, Map<String, BuildWinRates>> winRates,
    FetchBuildWinRatesFailedAction action) {
  return winRates;
}
