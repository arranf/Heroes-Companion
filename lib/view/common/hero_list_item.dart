import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:hots_dog_api/hots_dog_api.dart';

class HeroListItem extends StatelessWidget{
  final GestureTapCallback onTap;
  final HeroInfo heroInfo;

  HeroListItem({
    this.onTap,
    @required this.heroInfo,
  });

  @override
   Widget build(BuildContext context) {
     return new Row(key: new Key(heroInfo.name + '_hero_info'), children: <Widget>[
       new Text(heroInfo.name),
       new Text(heroInfo.role), 
     ],);
   }
}