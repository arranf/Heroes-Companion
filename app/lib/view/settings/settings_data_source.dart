import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';
import 'package:heroes_companion/redux/selectors/selectors.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion/services/settings_service.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:redux/redux.dart';

class SettingsDataSource extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => new _ViewModel.from(store),
        builder: (context, vm) {
          dynamic onChanged = (DataSource value) => vm.updateDataSource(value);
          return new Scaffold(
              appBar: new AppBar(title: const Text('Data Source')),
              body: new Column(
                children: <Widget>[
                  new RadioListTile<DataSource>(
                    title: new Text(DataSource.HotsDog.name),
                    value: DataSource.HotsDog,
                    groupValue: vm.dataSource,
                    onChanged: onChanged,
                  ),
                  new RadioListTile<DataSource>(
                    title: new Text(DataSource.HotsLogs.name),
                    value: DataSource.HotsLogs,
                    groupValue: vm.dataSource,
                    onChanged: onChanged,
                  ),
                ],
              ));
        });
  }
}

class _ViewModel {
  final DataSource dataSource;
  final dynamic updateDataSource;

  _ViewModel({this.dataSource, this.updateDataSource});

  factory _ViewModel.from(Store<AppState> store) {
    final dynamic updateDataSource = (DataSource dataSource) {
      Settings settings = settingsSelector(store.state);
      updateSettings(store, settings.copyWith(dataSource: dataSource));
      store.dispatch(new DataSourceChangedAction());
    };

    return new _ViewModel(
        dataSource: dataSourceSelector(store.state),
        updateDataSource: updateDataSource);
  }
}
