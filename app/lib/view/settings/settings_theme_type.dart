import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';
import 'package:heroes_companion/redux/selectors/selectors.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion/services/settings_service.dart';
import 'package:heroes_companion/view/i18n/strings.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:redux/redux.dart';

class SettingsThemeType extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SettingsThemeTypeState();
}

class _SettingsThemeTypeState extends State<SettingsThemeType> {
  bool _haveChangedNow = false;

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => new _ViewModel.from(store),
        builder: (BuildContext context, _ViewModel vm) {
          return new Scaffold(
              appBar: new AppBar(title: new Text(AppStrings.of(context).theme())),
              body: new Builder(
                builder: (BuildContext context) {
                  dynamic onChanged = (ThemeType value) {
                    if (!_haveChangedNow) {
                      Scaffold.of(context).showSnackBar(new SnackBar(
                            content: new Text(
                                AppStrings.of(context).thisSettingWillUpdateOnNextLaunch()),
                          ));
                      _haveChangedNow = true;
                    }
                    vm.updateThemeType(value);
                  };
                  return new Column(
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
                  );
                },
              ));
        });
  }
}

class _ViewModel {
  final ThemeType themeType;
  final dynamic updateThemeType;

  _ViewModel({this.themeType, this.updateThemeType});

  factory _ViewModel.from(Store<AppState> store) {
    final dynamic updateThemeType = (ThemeType themeType) {
      Settings settings = settingsSelector(store.state);
      updateSettings(store, settings.copyWith(themeType: themeType));
    };

    return new _ViewModel(
        themeType: themeTypeSelector(store.state),
        updateThemeType: updateThemeType);
  }
}
