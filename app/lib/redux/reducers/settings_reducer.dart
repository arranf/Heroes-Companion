import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';

final settingsReducer = combineTypedReducers<Settings>(
    [new ReducerBinding<Settings, UpdateSettingsAction>(_settings)]);

Settings _settings(Settings settings, UpdateSettingsAction action) {
  return action.settings;
}
