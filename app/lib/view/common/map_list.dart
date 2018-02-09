import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Hero;
import 'package:heroes_companion/view/common/app_loading_container.dart';
import 'package:heroes_companion/view/common/loading_view.dart';
import 'package:heroes_companion/view/common/map_list_item.dart';

import 'package:heroes_companion_data/heroes_companion_data.dart';

class MapList extends StatelessWidget {
  final List<PlayableMap> maps;
  final dynamic onTap;

  MapList(this.maps,
      {this.onTap})
      : super(key: new Key('map_list'));

  Widget _buildList(BuildContext context) {
    if (maps.isEmpty) {
      return new Container();
    }

    return new ListView.builder(
      key: new Key('map_list'),
      itemCount: maps.length,
      itemBuilder: (BuildContext context, int index) {
        return new MapListItem(
            map: maps[index],
            onTap: () => this.onTap(maps[index])
          );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new AppLoading(builder: (context, loading) {
      return loading ? new LoadingView() : new Container(
        child: _buildList(context));
    });
  }
}
