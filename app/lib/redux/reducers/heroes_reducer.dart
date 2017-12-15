import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';

final heroesReducer = combineTypedReducers<List<Hero>>([
  new ReducerBinding<List<Hero>, FetchHeroesSucceededAction>(_setLoadedHeroes),
  new ReducerBinding<List<Hero>, FetchHeroesFailedAction>(_setNoHeroes),
  new ReducerBinding<List<Hero>, UpdateHeroAction>(_updateHero),
]);

List<Hero> _setLoadedHeroes(List<Hero> hero, FetchHeroesSucceededAction action) {
  return action.heroes;
}

List<Hero> _setNoHeroes(List<Hero> hero, FetchHeroesFailedAction action) {
  return null;
}

List<Hero> _updateHero(List<Hero> heroes, UpdateHeroAction action) {
  return heroes
      .map((Hero hero) => hero.heroes_companion_hero_id == action.hero.heroes_companion_hero_id ? action.hero : hero)
      .toList(); 
}