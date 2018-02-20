import 'package:heroes_companion/redux/actions/actions.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion/services/exception_service.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:redux/redux.dart';


void getSettings(Store<AppState> store) {
  DataProvider.settingsProvider
      .readSettings()
      .then(
          (Settings settings) => store.dispatch(new UpdateSettingsAction(settings)))
      .catchError((Error e) 
      {
        new ExceptionService()
        .reportError(e);
      }); 
}

void updateSettings(Store<AppState> store, Settings settings) {
  DataProvider.settingsProvider
      .writeSettings(settings)
      .then((a) => store.dispatch(new UpdateSettingsAction(settings)))
      .catchError((Error e) 
      {
        new ExceptionService()
        .reportError(e);
      }); 
}