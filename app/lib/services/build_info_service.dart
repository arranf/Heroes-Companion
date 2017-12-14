import 'package:heroes_companion/redux/actions/actions.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:redux/redux.dart';

void getBuildInfo(Store<AppState> store) {
  store.dispatch(new StartLoadingAction());
  // TODO Change interface to actually throw an exception in the case we need special handling
  DataProvider.gameInfoProvider.getBuilds()
    .then((buildInfo) => store.dispatch(new BuildInfoLoadedAction(buildInfo)))
    .catchError((Exception e) => store.dispatch(new HeroesNotLoadedAction()));
}