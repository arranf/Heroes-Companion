import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  LoadingView();
  @override
  Widget build(BuildContext context) => new Container(
      color: Theme.of(context).backgroundColor,
      child: new Center(
          child: new CircularProgressIndicator(
        backgroundColor: Theme.of(context).backgroundColor,
        valueColor: new AlwaysStoppedAnimation(Theme.of(context).accentColor),
      )));
}
