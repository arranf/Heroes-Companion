import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Hero;
import 'package:heroes_companion/view/common/hero_list_item.dart';

import 'package:heroes_companion_data/heroes_companion_data.dart';

class HeroList extends StatelessWidget {
  final List<Hero> heroes;
  final Function onTap;
  final Function onLongPress;
  final Function onRefresh;
  final bool allowRefresh;

  HeroList(
    this.heroes, {
    this.onTap,
    this.onLongPress,
    this.onRefresh,
    this.allowRefresh = false
  })
      : super(key: new Key('hero_list'));
  
  Widget _buildRefresh(BuildContext context) {
    return new RefreshIndicator(
        key: new Key('hero_list_refresh'),
        onRefresh: onRefresh,
        child: _buildList(context)
    );
  }

  Widget _buildList(BuildContext context) {
    return new ListView.builder(
      key: new Key('hero_list'),
      itemCount: heroes.length,
      itemBuilder: (BuildContext context, int index) {
        return new HeroListItem(
            hero: heroes[index],
            onTap: this.onTap,
            onLongPress: this.onLongPress);
      },
    );
  } 

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: allowRefresh ? _buildRefresh(context) : _buildList(context)
    );
  }
}
