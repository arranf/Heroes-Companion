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

class FetchBuildInfoSucceededAction {
  final List<BuildInfo> buildInfo;

  FetchBuildInfoSucceededAction(this.buildInfo);
}

class FetchBuildInfoFailedAction {}

class FetchWinRatesSucceededAction {
  final WinRates winRates;

  FetchWinRatesSucceededAction(this.winRates);
}

class FetchWinRatesFailedAction {}

class FetchBuildWinRatesSucceededAction {
  final BuildWinRates buildWinRates;
  final int heroCompanionId;

  FetchBuildWinRatesSucceededAction(this.buildWinRates, this.heroCompanionId);
}

class FetchBuildWinRatesFailedAction {}

class BuildWinRatesStartLoadingAction {}

class SetSearchQueryAction {
  final String searchQuery;

  SetSearchQueryAction(this.searchQuery);
}

class ClearSearchQueryAction {}
