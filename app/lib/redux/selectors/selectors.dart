import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:hots_dog_api/hots_dog_api.dart';
import 'package:flutter/foundation.dart';

bool isLoadingSelector(AppState state) => state.isLoading;
List<Hero> heroesSelector(AppState state) => state.heroes;
Optional<Hero> heroSelectorByCompanionId(List<Hero> heroes, int id) {
  try {
    return new Optional.of(heroes.firstWhere((h) => h.heroes_companion_hero_id == id));
  }
  catch (e) {
    return new Optional.absent();
  }
}

BuildInfo currentBuildSelector(AppState state) {
  if (state.buildInfo == null) {
    throw new Exception('Build Info hasn''t been loaded');
  }
  return state.buildInfo[0];
}

WinRates winRatesSelector(AppState state) => state.winRates;

Optional<WinLossCount> winLossCountByCompanionId(AppState state, int id) {
  Optional<Hero> hero = heroSelectorByCompanionId(state.heroes, id);
  if (hero.isNotPresent){
    debugPrint('No hero found');
    return new Optional.absent();
  }
  try {
    return new Optional.of(state.winRates.current[hero.value.name]);
  }
  catch (e) {
    debugPrint("Winrates: ${state.winRates}, isLoading: ${state.isLoading}");
    return new Optional.absent();
  }
}