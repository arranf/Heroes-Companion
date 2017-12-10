import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:heroes_companion/redux/reducers/app_state.dart';
import 'package:heroes_companion/redux/middleware/game_info_middleware.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion/redux/actions/actions.dart';

import 'package:heroes_companion/routes.dart';
import 'package:heroes_companion/view/routes/home_view.dart';
import 'package:heroes_companion/view/common/splash.dart';

final String appName = 'Heroes Companion';
StreamSubscription<AppState> subscription;
App app;

void main() {
  // Listens to onChange events and when the initial load is completed the main app is run
  void listener(AppState state) {
    if (state.isLoading == false && state.gameInfo != null){
      subscription.cancel();
      runApp(app);
    }
  }

  // Run the splasscreen, create an instance of app, dispatch and event to load the initial data, and setup a listener to check for completion
  runApp(new Splash(appName));
  app = new App();
  subscription = app.store.onChange.listen(listener);
  app.store.dispatch(new LoadGameInfoAction());
}


class App extends StatelessWidget {
  final store = new Store<AppState>(
    appReducer,
    initialState: new AppState.loading(),
    middleware: createGameInfoMiddleware(),
  ); 

  App();

  @override
  Widget build(BuildContext context) => new StoreProvider(
      store: store,
      child: new MaterialApp(
        title: appName,
        theme: new ThemeData.light(),
        routes: {
          Routes.home: (context) {
            return new StoreBuilder<AppState>(
              onInit: (store) => store.dispatch(new LoadGameInfoAction()),
              builder: (context, store) {
                return new HomeScreen();
              },
            );
          }
        }
      ),
    );
}