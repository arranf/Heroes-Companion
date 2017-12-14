import 'package:heroes_companion/redux/actions/actions.dart';
import 'package:heroes_companion/redux/selectors/selectors.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:redux/redux.dart';

void getCurrentWinRates(Store<AppState> store) {
  store.dispatch(new StartLoadingAction());
  // TODO Change interface to actually throw an exception in the case we need special handling
  DataProvider.winRateProvider.getWinRates(currentBuildSelector(store.state).number)
    .then((winRates) => store.dispatch(new WinRatesLoadedAction(winRates)))
    .catchError((Exception e) => store.dispatch(new WinRatesNotLoadedAction()));
}