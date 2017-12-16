import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  LoadingView();
  @override
  Widget build(BuildContext context) => new Container(
      color: Colors.white,
      child: new Center(
          child: new CircularProgressIndicator(
        backgroundColor: Colors.white,
        valueColor: new AlwaysStoppedAnimation(Theme.of(context).primaryColor),
      )));
}
