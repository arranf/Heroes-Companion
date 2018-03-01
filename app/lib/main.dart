import 'dart:async';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:heroes_companion/redux/selectors/selectors.dart';
import 'package:heroes_companion/services/exception_service.dart';
import 'package:heroes_companion/services/patch_service.dart';
import 'package:heroes_companion/services/settings_service.dart';
import 'package:heroes_companion/services/update_service.dart';
import 'package:heroes_companion/view/common/launch_error.dart';
import 'package:heroes_companion/view/containers/hero_home_container.dart';
import 'package:heroes_companion/view/containers/hero_search_container.dart';
import 'package:heroes_companion/view/containers/maps_home_container.dart';
import 'package:heroes_companion/view/i18n/strings.dart';
import 'package:heroes_companion/view/settings/settings.dart';
import 'package:heroes_companion/view/settings/settings_data_source.dart';
import 'package:heroes_companion/view/settings/settings_theme_type.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart' hide Settings;


import 'package:heroes_companion/services/heroes_service.dart';
import 'package:heroes_companion/redux/reducers/app_state.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion/routes.dart';
import 'package:heroes_companion/view/common/splash.dart';

final String appName = 'Heroes Companion';
StreamSubscription<AppState> subscription;
App app;

void main() {
  ExceptionService exceptionService = new ExceptionService();

  // Listens to onChange events and when the initial load is completed the main app is run
  void listener(AppState state) {
    if (!isAppLoading(state) &&
        heroesSelector(state) != null &&
        patchesSelector(state) != null &&
        patchesSelector(state).isNotEmpty) {
      subscription.cancel();
      runZoned<Future<Null>>(() async {
        runApp(app);
      }, onError: (error, stackTrace) async {
        exceptionService.reportErrorAndStackTrace(error, stackTrace);
      });
    }
  }

  // Run the splasscreen, create an instance of app, dispatch and event to load the initial data, and setup a listener to check for completion
  app = new App();
  runApp(new Splash(appName));

  // Create a dataprovider singleton, start it then when it's ready dispatch an event
  new DataProvider();
  subscription = app.store.onChange.listen(listener);
  DataProvider.start().then((b) async {
    getSettings(app.store);
    getHeroes(app.store);
    getPatches(app.store);
  }).then((a) {
    tryUpdate(app.store);
    updatePatches(app.store);
  }).catchError((e) {
    if (ExceptionService.isDebug) {
      throw e;
    } else {
      exceptionService.reportError(e);
      runApp(new LaunchError(appName, e.toString()));
    }
  });
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppStrings> {
  @override
  Future<AppStrings> load(Locale locale) => AppStrings.load(locale);

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'en';

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

class App extends StatelessWidget {
  final store =
      new Store<AppState>(appReducer, initialState: new AppState.initial());

  App();

  final ThemeData lightTheme = new ThemeData(
      primarySwatch: Colors.deepPurple,
      accentColor: Colors.orangeAccent,
      backgroundColor: Colors.white);

  final ThemeData darkTheme = new ThemeData.dark().copyWith(
      accentColor: Colors.orangeAccent, buttonColor: Colors.deepPurple);

  @override
  Widget build(BuildContext context) => new StoreProvider(
        store: store,
        child: new MaterialApp(
            title: appName,
            theme: themeTypeSelector(store.state) == ThemeType.Light
                ? lightTheme
                : darkTheme,
            localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        new _AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        const Locale('en', 'US'),
        const Locale('es', 'ES'),
      ],
            // Named routes only
            // TODO move these into separate file
            routes: {
              Routes.home: (BuildContext context) {
                return new StoreBuilder<AppState>(
                  builder: (context, store) {
                    return new HeroHome();
                  },
                );
              },
              Routes.search: (BuildContext context) {
                return new StoreBuilder<AppState>(builder: (context, store) {
                  return new HeroSearch();
                });
              },
              Routes.maps: (BuildContext context) {
                return new StoreBuilder<AppState>(
                  builder: (context, store) {
                    return new MapsHome();
                  },
                );
              },
              Routes.settings: (BuildContext context) =>
                  new StoreBuilder<AppState>(
                      builder: (context, store) => new Settings()),
              Routes.settingsDataSource: (BuildContext context) =>
                  new StoreBuilder<AppState>(
                      builder: (context, store) => new SettingsDataSource()),
              Routes.settingsThemeType: (BuildContext context) =>
                  new StoreBuilder<AppState>(
                      builder: (context, store) => new SettingsThemeType()),
            }),
      );
}
