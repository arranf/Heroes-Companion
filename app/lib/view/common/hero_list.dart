import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Hero;
import 'package:heroes_companion/view/common/hero_list_item.dart';

import 'package:heroes_companion_data/heroes_companion_data.dart';

class HeroList extends StatelessWidget {
  final List<Hero> heroes;
  final Function onTap;
  final Function onLongPress;

  HeroList(
    this.heroes, {
    this.onTap,
    this.onLongPress,
  })
      : super(key: new Key('hero_list'));

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new ListView.builder(
      key: new Key('hero_list'),
      itemCount: heroes.length,
      itemBuilder: (BuildContext context, int index) {
        return new HeroListItem(
            hero: heroes[index],
            onTap: this.onTap,
            onLongPress: this.onLongPress);
      },
    ));
  }
}
