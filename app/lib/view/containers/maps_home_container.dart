import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:heroes_companion/redux/selectors/selectors.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion/services/maps_service.dart';
import 'package:heroes_companion/view/common/app_drawer.dart';
import 'package:heroes_companion/view/common/map_list.dart';
import 'package:heroes_companion/view/common/map_timer.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:redux/redux.dart';

class MapsHome extends StatelessWidget {
  MapsHome({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
     return new StoreConnector<AppState, _ViewModel>(
       onInit: (store) => getMaps(store),
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return new Scaffold(
          drawer: new AppDrawer(),
          appBar: new AppBar(title: new Text('Maps'),),
          body: new MapList(vm.maps, onTap: vm.onTap),
        );
      }
     );
  }
}

class _ViewModel {
  final List<PlayableMap> maps;
  final dynamic onTap = (BuildContext context, PlayableMap map) {
    Navigator.of(context).push(
      new PageRouteBuilder(
          pageBuilder: (context, a1, a2) => new MapTimer(map),
        ));
  };

  _ViewModel(this.maps);

  static _ViewModel fromStore(Store<AppState> store) {
    List<PlayableMap> maps = mapsSelector(store.state);

    if (maps == null) {
      maps = [];
    }

    return new _ViewModel(maps);
  }
}