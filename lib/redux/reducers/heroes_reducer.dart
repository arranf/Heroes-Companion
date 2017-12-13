import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';

final heroesReducer = combineTypedReducers<List<Hero>>([
  new ReducerBinding<List<Hero>, HeroesLoadedAction>(_setLoadedHeroes),
  new ReducerBinding<List<Hero>, HeroesNotLoadedAction>(_setNoHeroes),
  new ReducerBinding<List<Hero>, UpdateHeroAction>(_updateHero),
]);

List<Hero> _setLoadedHeroes(List<Hero> hero, HeroesLoadedAction action) {
  return action.heroes;
}

List<Hero> _setNoHeroes(List<Hero> hero, HeroesNotLoadedAction action) {
  return null;
}

List<Hero> _updateHero(List<Hero> heroes, UpdateHeroAction action) {
  return heroes
      .map((Hero hero) => hero.heroes_companion_hero_id == action.hero.heroes_companion_hero_id ? action.hero : hero)
      .toList(); 
}