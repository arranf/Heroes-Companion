import 'package:heroes_companion_data/heroes_companion_data.dart';

class HeroesNotLoadedAction {}

class HeroesLoadedAction {
  final List<Hero> heroes;

  HeroesLoadedAction(this.heroes);
}

class StartLoadingAction {}