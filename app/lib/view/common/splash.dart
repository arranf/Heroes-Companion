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
            body: new StoreConnector<AppState, bool>(
                distinct: true,
                converter: (Store<AppState> store) =>
                    isUpdatingSelector(store.state),
                builder: (BuildContext context, bool isUpdating) {
                  return isUpdating
                      ? _buildUpdatingSplash(context, appName)
                      : _buildRegularSplash(context, appName);
                }),
          ),
          theme: new ThemeData(
            primarySwatch: Colors.deepPurple,
            scaffoldBackgroundColor: Colors.deepPurple,
          )));
}

Widget _buildRegularSplash(BuildContext context, String appName) {
  return new Center(
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        new Text(appName,
            style: new TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w700,
                color: Colors.white)),
        new Text(
          'for Heroes of the Storm',
          style: new TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ]));
}

Widget _buildUpdatingSplash(BuildContext context, String appName) {
  return new Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      new Container(
        child: new Column(
          children: <Widget>[
            new Text(appName,
                style: new TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
            new Text(
              'for Heroes of the Storm',
              style: new TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ],
        ),
      ),
      new Center(
          child: new Column(
        children: <Widget>[
          new CircularProgressIndicator(
              value: null,
              backgroundColor: Colors.white,
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.amber)),
          new Padding(
              padding: new EdgeInsets.only(top: 20.0),
              child: new Text(
                'Updating $appName',
                style: new TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              )),
        ],
      )),
    ],
  );
}
