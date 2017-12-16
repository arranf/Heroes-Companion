import 'package:hots_dog_api/hots_dog_api.dart';
import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';

final heroesBuildWinRatesReducer =
    combineTypedReducers<Map<int, BuildWinRates>>([
  new ReducerBinding<Map<int, BuildWinRates>,
      FetchBuildWinRatesSucceededAction>(_succeed),
  new ReducerBinding<Map<int, BuildWinRates>, FetchBuildWinRatesFailedAction>(
      _fail)
]);

Map<int, BuildWinRates> _succeed(Map<int, BuildWinRates> winRates,
    FetchBuildWinRatesSucceededAction action) {
  Map<int, BuildWinRates> newWinRates = new Map<int, BuildWinRates>.from(
      winRates ?? new Map<int, BuildWinRates>());
  newWinRates[action.heroCompanionId] = action.buildWinRates;
  return newWinRates;
}

Map<int, BuildWinRates> _fail(
    Map<int, BuildWinRates> winRates, FetchBuildWinRatesFailedAction action) {
  return winRates;
}
