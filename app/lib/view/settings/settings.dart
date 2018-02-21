import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:heroes_companion/redux/selectors/selectors.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion/routes.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:redux/redux.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => new _ViewModel.from(store),
      builder: (context, vm) {
        return new Scaffold(
          appBar: new AppBar(
            title: const Text('Settings')
          ),
          body: new ListView(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            children: [
              new ListTile(
                leading: const Icon(Icons.cloud_download),
                title: new Text('Data Source'),
                subtitle: new Text('Current: ${vm.dataSource.name}'),
                onTap: () => Navigator.of(context).pushNamed(Routes.settingsDataSource),
              )
            ],
          )
        );
      });
  }
}

class _ViewModel {
  final DataSource dataSource;
  final dynamic updateDataSource;

  _ViewModel({this.dataSource, this.updateDataSource});

  factory _ViewModel.from(Store<AppState> store){
    return new _ViewModel(
        dataSource: dataSourceSelector(store.state)
    );
  }
}