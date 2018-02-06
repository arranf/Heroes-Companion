import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:heroes_companion/redux/selectors/selectors.dart';
import 'package:heroes_companion/services/patch_service.dart';
import 'package:heroes_companion/services/update_service.dart';
import 'package:heroes_companion/view/common/launch_error.dart';
import 'package:heroes_companion/view/containers/hero_home_container.dart';
import 'package:heroes_companion/view/containers/hero_search_container.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';

import 'package:heroes_companion/services/heroes_service.dart';
import 'package:heroes_companion/redux/reducers/app_state.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion/routes.dart';
import 'package:heroes_companion/view/common/splash.dart';
import 'package:sentry/sentry.dart';

import 'dsn.dart';

final SentryClient _sentry = new SentryClient(dsn: dsn);
bool isDebug = false;

/// Reports [error] along with its [stackTrace] to Sentry.io.
Future<Null> _reportError(dynamic error, dynamic stackTrace) async {
  print('Caught error: $error');
  print('Reporting to Sentry.io...');

  final SentryResponse response = await _sentry.captureException(
    exception: error,
    stackTrace: stackTrace,
  );

  if (response.isSuccessful) {
    print('Success! Event ID: ${response.eventId}');
  } else {
    print('Failed to report to Sentry.io: ${response.error}');
  }
}

final String appName = 'Heroes Companion';
StreamSubscription<AppState> subscription;
App app;

Future main() async {
  // Test if debug
  assert(() => isDebug = true);
  if (!isDebug) {
    FlutterError.onError = (FlutterErrorDetails details) async {
    print('FlutterError.onError caught an error');
    await _reportError(details.exception, details.stack);
    };

    Isolate.current.addErrorListener(new RawReceivePort((dynamic pair) async {
      print('Isolate.current.addErrorListener caught an error');
      await _reportError(
        (pair as List<String>).first,
        (pair as List<String>).last,
      );
    }).sendPort);
  }
  
  // Listens to onChange events and when the initial load is completed the main app is run
  void listener(AppState state) {
    if (!isAppLoading(state) &&
        heroesSelector(state) != null &&
        buildsSelector(state) != null &&
        buildsSelector(state).isNotEmpty) {
      subscription.cancel();
      runZoned<Future<Null>>(() async {
        runApp(app);
      }, onError: (error, stackTrace) async {
        if (!isDebug){
          await _reportError(error, stackTrace);
        }
        print('Zone caught an error');
      });
    }
  }

  // Run the splasscreen, create an instance of app, dispatch and event to load the initial data, and setup a listener to check for completion
  app = new App();
  runApp(new Splash(appName));
  debugPrint('Run Splashscreen');

  // Create a dataprovider singleton, start it then when it's ready dispatch an event
  new DataProvider();
  subscription = app.store.onChange.listen(listener);
  DataProvider.start().then((b) {
    getHeroes(app.store);
    getPatches(app.store);
  }).then((a) {
    tryUpdate(app.store);
    updatePatches(app.store);
  }).catchError((Error e) {
    if (isDebug) {
      throw e;
    } else {
      _reportError(e, e.stackTrace);
      runApp(new LaunchError(appName, e.toString()));
    }
  });
}

class App extends StatelessWidget {
  final store =
      new Store<AppState>(appReducer, initialState: new AppState.initial());

  App();

  @override
  Widget build(BuildContext context) => new StoreProvider(
        store: store,
        child: new MaterialApp(
            title: appName,
            theme: new ThemeData(
              primaryColor: Colors.deepPurple,
              accentColor: Colors.orangeAccent,
              backgroundColor: Colors.white,
              textTheme: new Typography(platform: TargetPlatform.android).black,
            ),
            // Named routes only
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
              }
            }),
      );
}
