import 'dart:async';

import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  final String appName;

  Splash(this.appName);

  @override
  State<StatefulWidget> createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  bool _error = false;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = new Timer(new Duration(seconds: 12), () => _setError());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => new MaterialApp(
      home: new Scaffold(
          body: !_error
              ? _buildRegularSplash(context, widget.appName)
              : _buildErrorSplash(context, widget.appName)),
      theme: new ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.deepPurple,
      ));

  void _setError() {
    setState(() {
      _error = true;
    });
    _timer.cancel();
  }

  Widget _buildErrorSplash(BuildContext context, String appName) {
    return new Center(
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          new Container(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(appName,
                    style: new TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                new Text(
                  'for Heroes of the Storm',
                  style: new TextStyle(fontSize: 16.0, color: Colors.white),
                )
              ],
            ),
          ),
          new Padding(
            padding: new EdgeInsets.symmetric(vertical: 32.0),
            child: new Text(
              'Loading seems to be taking a while. Please try again later.',
              style: new TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.white),
            ),
          )
        ]));
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
}
