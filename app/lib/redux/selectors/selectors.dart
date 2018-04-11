import 'package:heroes_companion/models/hero_filter.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:flutter/foundation.dart';

bool isAppLoading(AppState state) =>
    isLoadingSelector(state) ||
    heroStatisticalHeroBuildLoadingSelector(state) ||
    regularBuildsLoadingSelector(state);

bool isUpdatingSelector(AppState state) => state.isUpdating;

bool isLoadingSelector(AppState state) => state.isLoading;

bool heroStatisticalHeroBuildLoadingSelector(AppState state) =>
    state.staticialBuildsLoading;

bool regularBuildsLoadingSelector(AppState state) => state.regularBuildsLoading;

HeroFilter filterSelector(AppState state) => state.filter;

List<Hero> heroesSelector(AppState state) =>
    state.heroes == null ? new List<Hero>() : state.heroes;

List<Hero> favoriteHeroesSelector(AppState state) =>
    state.heroes.where((Hero h) => h.is_favorite).toList();

List<Hero> ownedHeroesSelector(AppState state) =>
    state.heroes.where((Hero h) => h.is_owned).toList();

List<Hero> freeToPlayHeroesSelector(AppState state) =>
    state.heroes.where((Hero h) => h.isOnRotation()).toList();

List<Hero> heroesbyFilterSelector(AppState state) {
  if (state.heroes == null) {
    return new List<Hero>();
  }
  
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

Optional<Hero> heroSelectorByHeroId(List<Hero> heroes, int id) {
  try {
    return new Optional.of(heroes.firstWhere((h) => h.hero_id == id));
  } catch (e) {
    return new Optional.absent();
  }
}

List<Patch> patchesSelector(AppState state) => state.patches;

Patch currentPatchSelector(AppState state) {
  if (state.patches == null && state.patches.isNotEmpty) {
    throw new Exception('Patches haven\'t been loaded');
  }
  Patch currentPatch = state.patches.firstWhere((Patch p) => p.hotsDogId != '');
  if (currentPatch == null) {
    throw new Exception('Unable to fetch current patch');
  }
  return currentPatch;
}

Patch previousPatchSelector(AppState state) {
  if (state.patches == null && state.patches.length < 2) {
    throw new Exception('Patches haven\'t been loaded');
  }

  int currentIndex = state.patches.indexOf(currentPatchSelector(state));
  if (currentIndex + 1 == state.patches.length - 1) {
    throw new Exception('Error getting previous build');
  }
  return state.patches[currentIndex + 1];
}

Map<String, List<HeroWinRate>> winRatesSelector(AppState state) =>
    state.winRates;

Optional<List<HeroWinRate>> winRatesByBuildNumber(
    AppState state, String buildNumber) {
  try {
    return new Optional.of(winRatesSelector(state)[buildNumber]);
  } catch (e) {
    return new Optional.absent();
  }
}

/// A map of build number to HeroWinRate
Optional<Map<String, HeroWinRate>> heroWinRateByHeroId(AppState state, int id) {
  if (winRatesSelector(state) == null) {
    return new Optional.absent();
  }
  Optional<Hero> hero = heroSelectorByHeroId(state.heroes, id);
  if (hero.isNotPresent) {
    debugPrint('No hero found');
    return new Optional.absent();
  }

  Map<String, HeroWinRate> heroWinRatesByBuild = new Map<String, HeroWinRate>();
  winRatesSelector(state)
      .forEach((String buildNumber, List<HeroWinRate> winRates) {
    heroWinRatesByBuild[buildNumber] =
        winRates.firstWhere((w) => w.heroId == hero.value.hero_id);
  });

  if (heroWinRatesByBuild.keys.isNotEmpty) {
    return new Optional.of(heroWinRatesByBuild);
  } else {
    return new Optional.absent();
  }
}

Optional<HeroWinRate> heroWinRateByHeroIdAndBuildNumber(
    AppState state, int id, String buildNumber) {
  if (winRatesSelector(state) == null) {
    return new Optional.absent();
  }
  Optional<Hero> hero = heroSelectorByHeroId(state.heroes, id);
  if (hero.isNotPresent) {
    debugPrint('No hero found');
    return new Optional.absent();
  }
  try {
    return new Optional.of(winRatesByBuildNumber(state, buildNumber)
        .value
        .firstWhere((w) => w.heroId == id));
  } catch (e) {
    debugPrint("No winrates found for {$hero.value.name}");
    return new Optional.absent();
  }
}

bool statisticalHeroBuildLoading(AppState state) =>
    state.staticialBuildsLoading;

Map<int, Map<String, List<StatisticalHeroBuild>>> statisticalHeroBuilds(
    AppState state) {
  return state.heroStatisticalBuildsByPatchNumber;
}

Optional<Map<String, List<StatisticalHeroBuild>>> statisticalBuildsByHeroId(
    AppState state, int id) {
  Map<int, Map<String, List<StatisticalHeroBuild>>> rates =
      statisticalHeroBuilds(state);
  if (rates != null && rates.containsKey(id)) {
    return new Optional.of(rates[id]);
  }
  return new Optional.absent();
}

Optional<List<StatisticalHeroBuild>> statisticalBuildsByHeroIdAndBuildNumber(
    AppState state, int id, String buildNumber) {
  Map<int, Map<String, List<StatisticalHeroBuild>>> rates =
      statisticalHeroBuilds(state);
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
  DateTime currentPatchLiveDate = currentPatchSelector(state).liveDate;
  String currentPatchDate =
      '${currentPatchLiveDate.year}-${currentPatchLiveDate.month.toString().padLeft(2, '0')}-${currentPatchLiveDate.day.toString().padLeft(2, '0')}';
  return 'heroespatchnotes.com/hero/${hero.short_name}.html#patch$currentPatchDate';
}

Settings settingsSelector(AppState state) {
  if (state.settings == null) {
    throw new Exception('Settings not fetched');
  }
  return state.settings;
}

DataSource dataSourceSelector(AppState state) {
  Settings settings = settingsSelector(state);
  if (settings.dataSource == null) {
    new Exception('Settings has no saved datsource');
  }
  return settingsSelector(state).dataSource;
}

ThemeType themeTypeSelector(AppState state) {
  Settings settings = settingsSelector(state);
  if (settings.themeType == null) {
    new Exception('Settings has no saved theme type');
  }
  return settingsSelector(state).themeType;
}

Map<int, List<Build>> regularBuildsSelector(AppState state) {
  return state.regularHeroBuilds;
}

Optional<List<Build>> regularBuildsByHeroId(AppState state, int heroId) {
  Map<int, List<Build>> heroBuilds = regularBuildsSelector(state);
  if (heroBuilds == null || !heroBuilds.containsKey(heroId)) {
    return new Optional.absent();
  }
  return new Optional.of(heroBuilds[heroId]);
}
