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
     return new Container(
       margin: new EdgeInsets.all(8.0),
       child: new Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           new Container(height: 2.0,),
           new Text(
             heroInfo.name,
            style: new TextStyle(
              fontSize: 18.0
            ),),
            new Container(height: 8.0,),
            new Text(heroInfo.role),
            new Container(
              margin: new EdgeInsets.symmetric(vertical: 8.0),
              height: 2.0,
              width: 18.0,
              color: Colors.deepPurpleAccent
          ),
         ],
       ),
     );
   }
}