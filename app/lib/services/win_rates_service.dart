import 'package:heroes_companion/redux/actions/actions.dart';
import 'package:heroes_companion/redux/selectors/selectors.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion/services/exception_service.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:redux/redux.dart';

void getCurrentWinRates(Store<AppState> store) {
  store.dispatch(new StartLoadingAction());
  // TODO Change interface to actually throw an exception in the case we need special handling
  Patch patch = currentPatchSelector(store.state);
  DataProvider.winRateProvider.getWinRates(patch).then((winRates) {
    store.dispatch(new FetchWinRatesSucceededAction(winRates, patch.fullVersion));
  }).catchError(
      (Error e)
      {
        new ExceptionService()
        .reportError(e);
       store.dispatch(new FetchWinRatesFailedAction());
      });
}

void getWinRatesForBuild(Store<AppState> store, Patch build) {
  store.dispatch(new StartLoadingAction());
  DataProvider.winRateProvider.getWinRates(build).then((winRates) {
    store.dispatch(new FetchWinRatesSucceededAction(winRates, build.fullVersion));
  })
  .catchError((e)
    {
      new ExceptionService()
      .reportError(e);
      store.dispatch(new FetchWinRatesFailedAction());
    });
}
