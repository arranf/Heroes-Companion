import 'package:heroes_companion/redux/actions/actions.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:redux/redux.dart';

void getHeroes(Store<AppState> store) {
  store.dispatch(new StartLoadingAction());
  DataProvider.heroProvider.getHeroes()
    .then((heroes) => store.dispatch(new HeroesLoadedAction(heroes)))
    .catchError((Exception e) => store.dispatch(new HeroesNotLoadedAction()));
}