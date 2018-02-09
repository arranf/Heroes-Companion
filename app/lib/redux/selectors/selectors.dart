import 'package:heroes_companion/models/hero_filter.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:hots_dog_api/hots_dog_api.dart';
import 'package:flutter/foundation.dart';

bool isAppLoading(AppState state) =>
    isLoadingSelector(state) || heroBuildWinRatesLoadingSelector(state);

bool isUpdatingSelector(AppState state) => state.isUpdating;

bool isLoadingSelector(AppState state) => state.isLoading;

bool heroBuildWinRatesLoadingSelector(AppState state) =>
    state.heroBuildWinRatesLoading;

HeroFilter filterSelector(AppState state) => state.filter;

List<Hero> heroesSelector(AppState state) => state.heroes == null ? new List<Hero>() : state.heroes;

List<Hero> favoriteHeroesSelector(AppState state) =>
    state.heroes.where((Hero h) => h.is_favorite).toList();

List<Hero> ownedHeroesSelector(AppState state) =>
    state.heroes.where((Hero h) => h.is_owned).toList();

List<Hero> freeToPlayHeroesSelector(AppState state) =>
    state.heroes.where((Hero h) => h.isOnRotation()).toList();

List<Hero> heroesbyFilterSelector(AppState state) {
  switch (filterSelector(state)) {
    case HeroFilter.all:
      return heroesSelector(state);
      break;
    case HeroFilter.owned:
      return ownedHeroesSelector(state);
      break;
    case HeroFilter.favorite:
      return favoriteHeroesSelector(state);
    case HeroFilter.freeToPlay:
      return freeToPlayHeroesSelector(state);
    default:
      return heroesSelector(state);
  }
}

Optional<Hero> heroSelectorByCompanionId(List<Hero> heroes, int id) {
  try {
    return new Optional.of(
        heroes.firstWhere((h) => h.heroes_companion_hero_id == id));
  } catch (e) {
    return new Optional.absent();
  }
}

List<Patch> buildsSelector(AppState state) => state.patches;

Patch currentBuildSelector(AppState state) {
  if (state.patches == null && state.patches.isNotEmpty) {
    throw new Exception('Patches haven\'t been loaded');
  }
  return state.patches[0];
}

Patch previousBuildSelector(AppState state) {
  if (state.patches == null && state.patches.length < 2) {
    throw new Exception('Patches haven\'t been loaded');
  }
  return state.patches[1];
}

Map<String, WinRates> winRatesSelector(AppState state) => state.winRates;

Optional<WinRates> winRatesByBuildNumber(AppState state, String buildNumber) {
  try {
    return new Optional.of(winRatesSelector(state)[buildNumber]);
  } catch (e) {
    return new Optional.absent();
  }
}

Optional<Map<String, WinLossCount>> winLossCountByCompanionId(
    AppState state, int id) {
  if (winRatesSelector(state) == null) {
    return new Optional.absent();
  }
  Optional<Hero> hero = heroSelectorByCompanionId(state.heroes, id);
  if (hero.isNotPresent) {
    debugPrint('No hero found');
    return new Optional.absent();
  }

  Map<String, WinLossCount> heroWinRatesByBuild =
      new Map<String, WinLossCount>();
  winRatesSelector(state).forEach((key, value) {
    heroWinRatesByBuild[key] = value.current[hero.value.name];
  });

  if (heroWinRatesByBuild.keys.isNotEmpty) {
    return new Optional.of(heroWinRatesByBuild);
  } else {
    return new Optional.absent();
  }
}

Optional<WinLossCount> winLossCountByCompanionIdAndBuildNumber(
    AppState state, int id, String buildNumber) {
  if (winRatesSelector(state) == null) {
    return new Optional.absent();
  }
  Optional<Hero> hero = heroSelectorByCompanionId(state.heroes, id);
  if (hero.isNotPresent) {
    debugPrint('No hero found');
    return new Optional.absent();
  }
  try {
    return new Optional.of(winRatesByBuildNumber(state, buildNumber)
        .value
        .current[hero.value.name]);
  } catch (e) {
    debugPrint("No winrates found for {$hero.value.name}");
    return new Optional.absent();
  }
}

bool buildWinRatesLoading(AppState state) => state.heroBuildWinRatesLoading;

Map<int, Map<String, BuildWinRates>> buildWinRates(AppState state) {
  return state.heroBuildWinRates;
}

Optional<Map<String, BuildWinRates>> buildWinRatesByCompanionId(
    AppState state, int id) {
  Map<int, Map<String, BuildWinRates>> rates = buildWinRates(state);
  if (rates != null && rates.containsKey(id)) {
    return new Optional.of(rates[id]);
  }
  return new Optional.absent();
}

Optional<BuildWinRates> buildWinRatesByCompanionIdAndBuildNumber(
    AppState state, int id, String buildNumber) {
  Map<int, Map<String, BuildWinRates>> rates = buildWinRates(state);
  if (rates == null || !rates.containsKey(id)) {
    return new Optional.absent();
  }

  try {
    return new Optional.of(rates[id][buildNumber]);
  } catch (e) {
    return new Optional.absent();
  }
}

List<PlayableMap> mapsSelector(AppState state) => state.maps;

String searchQuerySelector(AppState state) => state.searchQuery;

List<Hero> searchSelector(AppState state) {
  List<Hero> heroes = heroesSelector(state);
  if (heroes == null || heroes.isEmpty) {
    return new List<Hero>();
  }

  String query = searchQuerySelector(state).toLowerCase().trim();

  return heroes
      .where((h) =>
          h.name.toLowerCase().contains(query) ||
          h.role.toLowerCase() == query ||
          (h.additional_search_text.toLowerCase().contains(query) &&
              query.length > 2))
      .toList();
}

String currentPatchUrlForHero(AppState state, Hero hero) {
// https://heroespatchnotes.com/hero/greymane.html#patch2017-09-05
   DateTime currentPatchLiveDate = currentBuildSelector(state).liveDate;
   String currentPatchDate = currentPatchLiveDate.year.toString() + currentPatchLiveDate.month.toString().padLeft(2) + currentPatchLiveDate.day.toString().padLeft(2);
  return 'heroespatchnotes.com/hero/${hero.short_name}.html#patch$currentPatchDate';
}
