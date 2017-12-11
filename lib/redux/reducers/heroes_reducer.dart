import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';

final heroesReducer = combineTypedReducers<List<Hero>>([
  new ReducerBinding<List<Hero>, HeroesLoadedAction>(_setLoadedHeroes),
  new ReducerBinding<List<Hero>, HeroesNotLoadedAction>(_setNoHeroes),
]);

List<Hero> _setLoadedHeroes(List<Hero> hero, HeroesLoadedAction action) {
  return action.heroes;
}

List<Hero> _setNoHeroes(List<Hero> hero, HeroesNotLoadedAction action) {
  return null;
}