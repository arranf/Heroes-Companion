import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Hero;
import 'package:heroes_companion_data/heroes_companion_data.dart';

class HeroListItem extends StatelessWidget {
  final dynamic onTap;
  final dynamic onLongPress;
  final Hero hero;

  HeroListItem({
    this.onTap,
    this.onLongPress,
    @required this.hero,
  });

  @override
  Widget build(BuildContext context) {
    return new DecoratedBox(
      position: DecorationPosition.foreground,
      decoration: new BoxDecoration(
        border: new Border(
          bottom: new BorderSide(color: Theme.of(context).dividerColor, width: 0.0),
        ),
      ),
      child:  new ListTile(
        leading: new CircleAvatar(
          backgroundImage: new AssetImage('assets/images/heroes/${hero.icon_file_name}'),
        ),
        title: new Text(hero.name,
          style: new TextStyle(
            fontSize: 18.0,
          )),
        subtitle: new Text(hero.role),
        trailing: hero.is_favorite ? new Icon(Icons.favorite) : null,
        onTap: () => this.onTap(context, this),
        onLongPress: () => this.onLongPress(context, this),
      ),
    );
  }
}
