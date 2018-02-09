import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Hero;
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:heroes_companion/icons.dart' as HeroesIcons;

class MapListItem extends StatelessWidget {
  final dynamic onTap;
  final dynamic onLongPress;
  final PlayableMap map;

  MapListItem({
    this.onTap,
    this.onLongPress,
    @required this.map,
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
        title: new Text(map.name,
            style: new TextStyle(
              fontSize: 18.0,
            )),
        onTap: () => this.onTap(context, this),
        onLongPress: () => this.onLongPress(context, this),
      ),
    );
  }
}
