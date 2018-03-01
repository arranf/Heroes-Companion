import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:heroes_companion/redux/selectors/selectors.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion/routes.dart';
import 'package:heroes_companion/view/i18n/strings.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:redux/redux.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => new _ViewModel.from(store),
        builder: (context, vm) {
          return new Scaffold(
              appBar: new AppBar(title: new Text(AppStrings.of(context).settings())),
              body: new ListView(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                children: [
                  new ListTile(
                    leading: const Icon(Icons.cloud_download),
                    title: new Text(AppStrings.of(context).dataSource()),
                    subtitle: new Text('${AppStrings.of(context).current()}: ${vm.dataSource.name}'),
                    onTap: () => Navigator
                        .of(context)
                        .pushNamed(Routes.settingsDataSource),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.color_lens),
                    title: new Text(AppStrings.of(context).theme()),
                    subtitle: new Text('${AppStrings.of(context).current()}: ${vm.themeType.name}'),
                    onTap: () => Navigator
                        .of(context)
                        .pushNamed(Routes.settingsThemeType),
                  ),
                ],
              ));
        });
  }
}

class _ViewModel {
  final DataSource dataSource;
  final ThemeType themeType;
  final dynamic updateDataSource;

  _ViewModel({this.dataSource, this.updateDataSource, this.themeType});

  factory _ViewModel.from(Store<AppState> store) {
    return new _ViewModel(
        dataSource: dataSourceSelector(store.state),
        themeType: themeTypeSelector(store.state));
  }
}
