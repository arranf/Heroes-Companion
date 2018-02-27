import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Hero;
import 'package:heroes_companion_data/heroes_companion_data.dart';

class MapListItem extends StatelessWidget {
  final dynamic onTap;
  final PlayableMap map;

  MapListItem({
    this.onTap,
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
          leading: new CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage:
                new AssetImage('assets/images/maps/${map.map_icon_filename}'),
          ),
          title: new Text(map.name,
              style: new TextStyle(
                fontSize: 18.0,
              )),
          onTap: () => this.onTap(context, this.map)),
    );
  }
}
