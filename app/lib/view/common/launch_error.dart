import 'package:flutter/material.dart';

class LaunchError extends StatelessWidget {
  final String appName;
  final String error;

  LaunchError(this.appName, this.error);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
            body: new Column(children: [
             new Container(
               child: new Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.center,
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
             new Text(
               error,
               style: new TextStyle(color: Colors.white),
             )
        ], mainAxisAlignment: MainAxisAlignment.spaceAround)),
        theme: new ThemeData(
          primarySwatch: Colors.deepPurple,
          scaffoldBackgroundColor: Colors.red,
        ));
  }
}
