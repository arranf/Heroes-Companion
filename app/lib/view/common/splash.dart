import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  final String appName;

  Splash(this.appName);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
            body: new Column(
                children: [
                    new Center(
                        child: new Text(appName, style: new TextStyle(fontSize: 32.0, fontWeight: FontWeight.w700, color: Colors.white))),
                    new Center(
                        child: new Text('for Heroes of the Storm',
                            style: new TextStyle(fontSize: 16.0, color: Colors.white),))
        ], mainAxisAlignment: MainAxisAlignment.center)),
        theme: new ThemeData(
          primarySwatch: Colors.deepPurple,
          scaffoldBackgroundColor: Colors.deepPurple,
        ));
  }
}
