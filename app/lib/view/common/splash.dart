import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  final String appName;

  Splash(this.appName);

  @override
  Widget build(BuildContext context) => new MaterialApp(
      home: new Scaffold(body: _buildRegularSplash(context, appName)),
      theme: new ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.deepPurple,
      ));
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
