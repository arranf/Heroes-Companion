import 'package:heroes_companion/redux/actions/actions.dart';
import 'package:heroes_companion/redux/selectors/selectors.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:redux/redux.dart';
import 'package:flutter/foundation.dart';

void getHeroCurrentBuildWinRates(Store<AppState> store, Hero hero) {
  store.dispatch(new BuildWinRatesStartLoadingAction());
  Patch patch = currentBuildSelector(store.state);
  DataProvider.buildWinRatesProvider
      .getBuildWinRates(patch.fullVersion, hero.name)
      .then((buildWinRates) => store.dispatch(
          new FetchBuildWinRatesSucceededAction(
              buildWinRates, hero.heroes_companion_hero_id, patch.fullVersion)))
      .catchError((dynamic e) {
    debugPrint(e.toString());
    store.dispatch(new FetchBuildWinRatesFailedAction());
  });
}

void getHeroBuildWinRates(
    Store<AppState> store, Hero hero, String buildNumber) {
  store.dispatch(new BuildWinRatesStartLoadingAction());
  DataProvider.buildWinRatesProvider
      .getBuildWinRates(buildNumber, hero.name)
      .then((buildWinRates) => store.dispatch(
          new FetchBuildWinRatesSucceededAction(
              buildWinRates, hero.heroes_companion_hero_id, buildNumber)))
      .catchError((dynamic e) {
    debugPrint(e.toString());
    store.dispatch(new FetchBuildWinRatesFailedAction());
  });
}
