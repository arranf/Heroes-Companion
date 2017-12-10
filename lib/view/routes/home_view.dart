import 'package:flutter/material.dart';
// import 'package:hots_dog_api/hots_dog_api.dart';
import 'package:heroes_companion/routes.dart';

class HomeScreen extends StatelessWidget { 
  HomeScreen() : super(key: Routes.homeKey);

  @override
  Widget build(BuildContext context) {
        return new Scaffold(
          appBar: new AppBar( title: new Text('Heroes Companion'))
        );
  }
}