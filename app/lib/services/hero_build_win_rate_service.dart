import 'package:heroes_companion/redux/actions/actions.dart';
import 'package:heroes_companion/redux/selectors/selectors.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:hots_dog_api/hots_dog_api.dart';
import 'package:redux/redux.dart';
import 'package:flutter/foundation.dart';

void getHeroCurrentBuildWinRates(Store<AppState> store, Hero hero) {
  store.dispatch(new BuildWinRatesStartLoadingAction());
  BuildInfo buildInfo = currentBuildSelector(store.state);
  DataProvider.buildWinRatesProvider.getBuildWinRates(buildInfo.number, hero.name)
    .then((buildWinRates) => store.dispatch(new FetchBuildWinRatesSucceededAction(buildWinRates, hero.heroes_companion_hero_id)))
    .catchError((dynamic e) {
      debugPrint(e.toString()); 
      store.dispatch(new FetchBuildWinRatesFailedAction());
    });
}