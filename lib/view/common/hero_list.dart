import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heroes_companion/view/common/hero_list_item.dart';

import 'package:heroes_companion_data/heroes_companion_data.dart' as data;

class HeroList extends StatelessWidget {
  final List<data.Hero> heroes;

  HeroList(this.heroes) : super(key: new Key('todo_list'));

  @override
  Widget build(BuildContext context) {
    return new Container(child: new ListView.builder(
      key: new Key('todo_list'),
      itemCount: heroes.length,
      itemBuilder: (BuildContext context, int index) {
        final hero = heroes[index];

        return new HeroListItem(hero: hero);
      }),
    );
  }
}