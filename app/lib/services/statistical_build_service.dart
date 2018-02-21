import 'package:heroes_companion/redux/actions/actions.dart';
import 'package:heroes_companion/redux/selectors/selectors.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion/services/exception_service.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:redux/redux.dart';

void getCurrentPatchStatisticalBuilds(Store<AppState> store, Hero hero) {
    Patch patch = currentBuildSelector(store.state);
    getStatisticalBuilds(store, hero, patch);
}

void getStatisticalBuilds(Store<AppState> store, Hero hero, Patch patch) {
  store.dispatch(new StatisticalHeroBuildStartLoadingAction());
  DataProvider.buildProvider
      .getStatisticalBuilds(patch, hero.name)
      .then((List<StatisticalHeroBuild> statisticalBuilds) {
        return store.dispatch(
            new FetchStatisticalHeroBuildSucceededAction(
                statisticalBuilds, hero.hero_id, patch.fullVersion));
      })
      .catchError((dynamic e) {
        new ExceptionService()
        .reportError(e);
      store.dispatch(new FetchStatisticalHeroBuildFailedAction());
  });
}
