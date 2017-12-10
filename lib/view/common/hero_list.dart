import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heroes_companion/view/common/hero_list_item.dart';

import 'package:hots_dog_api/hots_dog_api.dart';

class HeroList extends StatelessWidget {
  final List<HeroInfo> heroes;

  HeroList(this.heroes) : super(key: new Key('todo_list'));

  @override
  Widget build(BuildContext context) {
    return new Container(child: new ListView.builder(
      key: new Key('todo_list'),
      itemCount: heroes.length,
      itemBuilder: (BuildContext context, int index) {
        final heroInfo = heroes[index];

        return new HeroListItem(heroInfo: heroInfo);
      }),
    );
  }
}