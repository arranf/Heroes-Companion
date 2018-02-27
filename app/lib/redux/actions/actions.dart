import 'package:heroes_companion/models/hero_filter.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';

class FetchHeroesFailedAction {}

class FetchHeroesSucceededAction {
  final List<Hero> heroes;

  FetchHeroesSucceededAction(this.heroes);
}

class StartLoadingAction {}

class UpdateHeroAction {
  final Hero hero;

  UpdateHeroAction(this.hero);
}

class FetchPatchesSucceededAction {
  final List<Patch> patches;

  FetchPatchesSucceededAction(this.patches);
}

class FetchPatchesFailedAction {}

class FetchWinRatesSucceededAction {
  final List<HeroWinRate> winRates;
  final String buildNumber;

  FetchWinRatesSucceededAction(this.winRates, this.buildNumber);
}

class FetchWinRatesFailedAction {}

class FetchStatisticalHeroBuildSucceededAction {
  final String buildNumber;
  final List<StatisticalHeroBuild> statisticalBuilds;
  final int heroId;

  FetchStatisticalHeroBuildSucceededAction(
      this.statisticalBuilds, this.heroId, this.buildNumber);
}

class FetchStatisticalHeroBuildFailedAction {}

class StatisticalHeroBuildStartLoadingAction {}

class SetSearchQueryAction {
  final String searchQuery;

  SetSearchQueryAction(this.searchQuery);
}

class ClearSearchQueryAction {}

class SetFilterAction {
  final HeroFilter filter;

  SetFilterAction(this.filter);
}

class StartUpdatingAction {}

class StopUpdatingAction {}

class FetchMapsFailedAction {}

class FetchMapsSucceededAction {
  final List<PlayableMap> maps;

  FetchMapsSucceededAction(this.maps);
}

class UpdateSettingsAction {
  final Settings settings;

  UpdateSettingsAction(this.settings);
}

class DataSourceChangedAction {}

class FetchHeroBuildsStartLoadingAction {}

class FetchHeroBuildsFailedAction {}

class FetchHeroBuildsSucceededAction {
  final List<Build> builds;
  final int heroId;

  FetchHeroBuildsSucceededAction(this.builds, this.heroId);
}
