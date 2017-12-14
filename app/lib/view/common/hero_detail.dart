import 'package:flutter/material.dart' hide Hero;
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:meta/meta.dart';

class HeroDetail extends StatelessWidget {
  final Hero hero;
  final dynamic favorite; 

  HeroDetail(this.hero, {key, @required this.favorite}) : super(key: key);
  
  @override
  Widget build (BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(hero.name),
        actions: [
          new IconButton(
            tooltip: hero.is_favorite ? 'Unfavorite ${hero.name}' : 'Favorite ${hero.name}',
            icon: new Icon(
              Icons.favorite,
              color: hero.is_favorite ? Colors.red : Theme.of(context).buttonColor
            ),
            onPressed: () => this.favorite(this.hero),
          ),
        ],
      ),
      body: new Padding(
        padding: new EdgeInsets.all(16.0),
        child: new ListView(
          children: [
            new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Padding(
                  padding: new EdgeInsets.only(right: 8.0),
                  child: new Checkbox(
                    value: hero.is_owned,
                    onChanged: (value) => debugPrint('Collect'),
                  ),
                ),
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Padding(
                        padding: new EdgeInsets.only(
                          top: 8.0,
                          bottom: 16.0,
                        ),
                        child: new Text(
                          hero.name,
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ),
                      new Text(
                        hero.role,
                        style: Theme.of(context).textTheme.subhead,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}