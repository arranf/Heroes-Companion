import 'package:flutter/material.dart';
import 'package:heroes_companion/routes.dart';
import 'package:heroes_companion/view/routes/hero_home_container.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen() : super(key: Routes.homeKey);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Heroes Companion')),
      body: new HeroHome(),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.search),
        onPressed: () => Navigator.of(context).pushNamed(Routes.search),
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }
}
