import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';

final regularHeroBuildsReducer =
    combineTypedReducers<Map<int, List<Build>>>([
  new ReducerBinding<Map<int, List<Build>>,
      FetchHeroBuildsSucceededAction>(_succeed),
  new ReducerBinding<Map<int, List<Build>>,
      FetchHeroBuildsFailedAction>(_fail)
]);

Map<int, List<Build>> _succeed(
    Map<int, List<Build>> regularHeroBuilds,
    FetchHeroBuildsSucceededAction action) {
  Map<int, List<Build>> newRegularBuilds =
      new Map<int, List<Build>>.from(
          regularHeroBuilds ?? new Map<int, List<Build>>());

  newRegularBuilds[action.heroId] = action.builds;
  return newRegularBuilds;
}

Map<int, List<Build>> _fail(
    Map<int, List<Build>> winRates,
    FetchHeroBuildsFailedAction action) {
  return winRates;
}
