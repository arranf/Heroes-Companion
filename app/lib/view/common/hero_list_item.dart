import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Hero;
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:heroes_companion/icons.dart' as HeroesIcons;

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
          bottom:
              new BorderSide(color: Theme.of(context).dividerColor, width: 0.0),
        ),
      ),
      child: new ListTile(
        leading: new CircleAvatar(
          backgroundImage: hero.have_assets
              ? new AssetImage('assets/images/heroes/${hero.icon_file_name}')
              : new CachedNetworkImageProvider(
                  'https://images.heroescompanion.com/heroes/${hero.icon_file_name}'),
        ),
        title: new Text(hero.name,
            style: new TextStyle(
              fontSize: 18.0,
            )),
        subtitle: new Text(hero.role),
        trailing: new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            hero.is_favorite ? new Icon(Icons.favorite) : new Container(),
            hero.isOnRotation()
                ? new Icon(HeroesIcons.hexagon)
                : new Container(),
          ],
        ),
        onTap: () => this.onTap(context, this),
        onLongPress: () => this.onLongPress(context, this),
      )
    );
  }
}
