import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Hero;
import 'package:heroes_companion/view/common/hero_list_item.dart';

import 'package:heroes_companion_data/heroes_companion_data.dart';

class HeroList extends StatelessWidget {
  final List<Hero> heroes;
  final Function onTap;

  HeroList(
    this.heroes, {
    this.onTap,
  })
      : super(key: new Key('hero_list'));

  @override
  Widget build(BuildContext context) {
    List<Widget> heroChildren = [];
    this.heroes.forEach((hero){
      HeroListItem li = new HeroListItem(hero: hero, onTap: this.onTap);
      heroChildren.add(li.build(context));
    });
    return new Container(
      padding: new EdgeInsets.only(top: 4.0),
      child: new GridView.count(
          key: new Key('hero_list'),
          children: heroChildren, 
          shrinkWrap: true,
          primary: false,
          crossAxisCount: 2,
    ));
  }
}
