import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Hero;
import 'package:heroes_companion_data/heroes_companion_data.dart';

class HeroListItem extends StatelessWidget{
  final dynamic onTap;
  final dynamic favorite;
  final Hero hero;

  HeroListItem({
    this.onTap,
    this.favorite,
    @required this.hero,
  });

  @override
   Widget build(BuildContext context) {
    return new GestureDetector(
     onTapUp: (TapUpDetails tap) => this.onTap(context, this),
     child: new Container(
       margin: new EdgeInsets.all(8.0),
       child: new Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           new Container(height: 2.0,),
           new Row(children: <Widget>[
             new Text(
             hero.name,
            style: new TextStyle(
              fontSize: 18.0,
            )),
            new Icon(Icons.star, color: hero.is_favorite ? Colors.grey : Colors.purpleAccent,),
            new Text(hero.abilities == null ? '' : hero.abilities[0].name)
           ],),
          new Container(height: 8.0,),
          new Text(hero.role),
          new Container(
            margin: new EdgeInsets.symmetric(vertical: 8.0),
            height: 2.0,
            width: 18.0,
            color: Colors.deepPurpleAccent
          ),
         ],
       ),
     ));
  }
}