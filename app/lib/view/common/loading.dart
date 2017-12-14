import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {

  LoadingView();
  @override
  Widget build(BuildContext context) =>
      new Center(child: new CircularProgressIndicator());
}