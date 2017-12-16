import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Hero;
import 'package:heroes_companion/view/common/hero_grid_item.dart';

import 'package:heroes_companion_data/heroes_companion_data.dart';

class HeroGrid extends StatelessWidget {
  final List<Hero> heroes;
  final Function onTap;

  HeroGrid(
    this.heroes, {
    this.onTap,
  })
      : super(key: new Key('hero_list'));

  @override
  Widget build(BuildContext context) {
    List<Widget> heroChildren = [];
    this.heroes.forEach((hero){
      HeroGridItem li = new HeroGridItem(hero: hero, onTap: this.onTap);
      heroChildren.add(li.build(context));
    });
    return new Container(
      child: new GridView.count(
          key: new Key('hero_list'),
          children: heroChildren, 
          primary: false,
          crossAxisCount: 2,
    ));
  }
}
