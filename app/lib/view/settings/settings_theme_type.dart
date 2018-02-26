import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';
import 'package:heroes_companion/redux/selectors/selectors.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion/services/settings_service.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:redux/redux.dart';


class SettingsThemeType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => new _ViewModel.from(store),
        builder: (context, vm) {
        dynamic onChanged = (ThemeType value) => vm.updateThemeType(value);
          return new Scaffold(
            appBar: new AppBar(
              title: const Text('Data Source')
            ),
            body: new Column(
            children: <Widget>[
              new RadioListTile<ThemeType>(
                title: new Text(ThemeType.Light.name),
                value: ThemeType.Light,
                groupValue: vm.themeType,
                onChanged: onChanged,
              ),
              new RadioListTile<ThemeType>(
                title: new Text(ThemeType.Dark.name),
                value: ThemeType.Dark,
                groupValue: vm.themeType,
                onChanged: onChanged,
              ),
            ],
          )
        );
      });
  }
}

class _ViewModel {
  final ThemeType themeType;
  final dynamic updateThemeType;

  _ViewModel({this.themeType, this.updateThemeType});

  factory _ViewModel.from(Store<AppState> store){

    final dynamic updateThemeType = (ThemeType themeType) {
      Settings settings = settingsSelector(store.state);
      updateSettings(store, settings.copyWith(themeType: themeType));
    };

    return new _ViewModel(
        themeType: themeTypeSelector(store.state),
        updateThemeType: updateThemeType
    );
  }
}