import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';

final heroesStatisticalBuildsReducer =
    combineTypedReducers<Map<int, Map<String, List<StatisticalHeroBuild>>>>([
  new ReducerBinding<Map<int, Map<String, List<StatisticalHeroBuild>>>,
      FetchStatisticalHeroBuildSucceededAction>(_succeed),
  new ReducerBinding<Map<int, Map<String, List<StatisticalHeroBuild>>>,
      FetchStatisticalHeroBuildFailedAction>(_fail),
  new ReducerBinding<Map<int, Map<String, List<StatisticalHeroBuild>>>,
      DataSourceChangedAction>(_clear)
]);

Map<int, Map<String, List<StatisticalHeroBuild>>> _succeed(
    Map<int, Map<String, List<StatisticalHeroBuild>>> winRates,
    FetchStatisticalHeroBuildSucceededAction action) {
  Map<int, Map<String, List<StatisticalHeroBuild>>> newWinRates =
      new Map<int, Map<String, List<StatisticalHeroBuild>>>.from(
          winRates ?? new Map<int, Map<String, List<StatisticalHeroBuild>>>());
  newWinRates[action.heroId] = new Map<String, List<StatisticalHeroBuild>>.from(
      newWinRates[action.heroId] ?? new Map<String, StatisticalHeroBuild>());
  newWinRates[action.heroId][action.buildNumber] = action.statisticalBuilds;
  return newWinRates;
}

Map<int, Map<String, List<StatisticalHeroBuild>>> _fail(
    Map<int, Map<String, List<StatisticalHeroBuild>>> winRates,
    FetchStatisticalHeroBuildFailedAction action) {
  return winRates;
}

Map<int, Map<String, List<StatisticalHeroBuild>>> _clear(
    Map<int, Map<String, List<StatisticalHeroBuild>>> winRates,
    DataSourceChangedAction action) {
  return new Map<int, Map<String, List<StatisticalHeroBuild>>>();
}
