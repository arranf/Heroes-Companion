import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';

final settingsReducer = combineReducers<Settings>(
    [new TypedReducer<Settings, UpdateSettingsAction>(_settings)]);

Settings _settings(Settings settings, UpdateSettingsAction action) {
  return action.settings;
}
