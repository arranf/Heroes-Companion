import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:hots_dog_api/hots_dog_api.dart';

class HeroesNotLoadedAction {}

class HeroesLoadedAction {
  final List<Hero> heroes;

  HeroesLoadedAction(this.heroes);
}

class StartLoadingAction {}

class UpdateHeroAction {
  final Hero hero;

  UpdateHeroAction(this.hero);
}

class BuildInfoLoadedAction {
  final List<BuildInfo> buildInfo;

  BuildInfoLoadedAction(this.buildInfo);
}

class BuildInfoNotLoadedAction {}