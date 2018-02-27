import 'package:heroes_companion/redux/actions/actions.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion/services/exception_service.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:redux/redux.dart';

void getMaps(Store<AppState> store) {
  store.dispatch(new StartLoadingAction());

  DataProvider.mapProvider.getMaps().then((List<PlayableMap> maps) {
    store.dispatch(new FetchMapsSucceededAction(maps));
  }).catchError((Error e) {
    new ExceptionService().reportError(e);
    store.dispatch(new FetchMapsFailedAction());
  });
}
