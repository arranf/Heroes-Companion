import 'package:heroes_companion/redux/actions/actions.dart';
import 'package:heroes_companion/redux/selectors/selectors.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:redux/redux.dart';
import 'package:flutter/foundation.dart';

void getCurrentWinRates(Store<AppState> store) {
  store.dispatch(new StartLoadingAction());
  // TODO Change interface to actually throw an exception in the case we need special handling
  String buildNumber = currentBuildSelector(store.state).number;
  DataProvider.winRateProvider.getWinRates(buildNumber).then((winRates) {
    store.dispatch(new FetchWinRatesSucceededAction(winRates, buildNumber));
  }).catchError(
      (Exception e) => store.dispatch(new FetchWinRatesFailedAction()));
}

void getWinRatesForBuild(Store<AppState> store, String buildNumber) {
  store.dispatch(new StartLoadingAction());
  DataProvider.winRateProvider.getWinRates(buildNumber).then((winRates) {
    store.dispatch(new FetchWinRatesSucceededAction(winRates, buildNumber));
  }).catchError((e) => store.dispatch(new FetchWinRatesFailedAction()));
}
