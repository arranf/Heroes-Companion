import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:heroes_companion/redux/selectors/selectors.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:redux/redux.dart';

class Splash extends StatelessWidget {
  final String appName;
  final Store<AppState> store;

  Splash(this.appName, this.store);

  @override
  Widget build(BuildContext context) => new StoreProvider(
        store: store,
        child: new MaterialApp(
        home: new Scaffold(
          body: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Text(appName, 
                style: new TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)
              ),
              new Text(
                'for Heroes of the Storm',
                style: new TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              new StoreConnector<AppState, bool>(
                distinct: true,
                converter: (Store<AppState> store) => isUpdatingSelector(store.state),
                builder: (BuildContext context, bool isUpdating) => isUpdating ? new CircularProgressIndicator(value: null,) : new Container()
              )
            ])),
        theme: new ThemeData(
          primarySwatch: Colors.deepPurple,
          scaffoldBackgroundColor: Colors.deepPurple,
        ))
      );
}
