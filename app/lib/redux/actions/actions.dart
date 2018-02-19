import 'package:heroes_companion/models/hero_filter.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:hots_dog_api/hots_dog_api.dart';

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

class FetchBuildWinRatesSucceededAction {
  final String buildNumber;
  final BuildWinRates buildWinRates;
  final int heroId;

  FetchBuildWinRatesSucceededAction(
      this.buildWinRates, this.heroId, this.buildNumber);
}

class FetchBuildWinRatesFailedAction {}

class BuildWinRatesStartLoadingAction {}

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
