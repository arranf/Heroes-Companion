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
                 children: <Widget>[
                   new Text(appName,
                      style: new TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                  new Text(
                    'for Heroes of the Storm',
                    style: new TextStyle(fontSize: 16.0),
                  )
                 ],
               ),
             ),

             new Container(
               height: 60.0,
             ),
             new Text('Something Went Wrong', style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),),
             new Text(
               error,
             )
        ], 
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        )),
        theme: new ThemeData(
          primarySwatch: Colors.deepPurple,
          scaffoldBackgroundColor: Colors.red,
          textTheme: new Typography(platform: TargetPlatform.android).white
        ));
  }
}
