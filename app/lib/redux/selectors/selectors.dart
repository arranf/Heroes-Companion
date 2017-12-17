import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:hots_dog_api/hots_dog_api.dart';
import 'package:flutter/foundation.dart';

bool isAppLoading(AppState state) =>
    state.isLoading && state.heroBuildWinRatesLoading;

bool isLoadingSelector(AppState state) => state.isLoading;

List<Hero> heroesSelector(AppState state) => state.heroes;

Optional<Hero> heroSelectorByCompanionId(List<Hero> heroes, int id) {
  try {
    return new Optional.of(
        heroes.firstWhere((h) => h.heroes_companion_hero_id == id));
  } catch (e) {
    return new Optional.absent();
  }
}

List<BuildInfo> buildsSelector(AppState state) => state.gameBuilds;

BuildInfo currentBuildSelector(AppState state) {
  if (state.gameBuilds == null) {
    throw new Exception('Build Info hasn' 't been loaded');
  }
  return state.gameBuilds[0];
}

WinRates winRatesSelector(AppState state) => state.winRates;

Optional<WinLossCount> winLossCountByCompanionId(AppState state, int id) {
  if (winRatesSelector(state) == null){
    throw new Exception('Winrates not loaded');
  }
  Optional<Hero> hero = heroSelectorByCompanionId(state.heroes, id);
  if (hero.isNotPresent) {
    debugPrint('No hero found');
    return new Optional.absent();
  }
  try {
    return new Optional.of(winRatesSelector(state).current[hero.value.name]);
  } catch (e) {
    debugPrint("No winrates found for {$hero.value.name}");
    return new Optional.absent();
  }
}

bool buildWinRatesLoading(AppState state) => state.heroBuildWinRatesLoading;

Map<int, BuildWinRates> buildWinRates(AppState state) {
  return state.heroBuildWinRates;
}

Optional<BuildWinRates> buildWinRatesByCompanionId(AppState state, int id) {
  Map<int, BuildWinRates> rates = buildWinRates(state);
  if (rates != null && rates.containsKey(id)) {
    return new Optional.of(rates[id]);
  }
  return new Optional.absent();
}
