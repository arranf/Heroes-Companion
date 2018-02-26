import 'dart:async';

import 'package:heroes_companion_data/src/models/data_source.dart';
import 'package:heroes_companion_data/src/models/settings.dart';
import 'package:heroes_companion_data/src/models/theme_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:heroes_companion_data/src/shared_preferences_keys.dart'
    as pref_keys;

class SettingsProvider {
  Settings _settings = null;

  Future<Settings> readSettings() async {
    if (_settings != null) {
      return new Future.value(_settings);
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    
    // Update Time
    String currentUpdateOriginTimeUnparsed = preferences.getString(pref_keys.update_id);
    DateTime currentUpdateOriginTime = new DateTime(1970);
    if (currentUpdateOriginTimeUnparsed != null && currentUpdateOriginTimeUnparsed.isNotEmpty) {
      currentUpdateOriginTime = DateTime.parse(currentUpdateOriginTimeUnparsed);
    }

    String updatePatchVersion = preferences.getString(pref_keys.update_patch);

    String unparsedRotationDate = (preferences.getString(pref_keys.next_rotation_date) ?? '');
    DateTime rotationDate = unparsedRotationDate.isEmpty ? new DateTime(1970)
          : DateTime.parse(unparsedRotationDate);

    ThemeType themeType = ThemeType.fromString(preferences.getString(pref_keys.theme_type));

    DataSource dataSource = DataSource.fromString(preferences.getString(pref_keys.data_source));

    _settings = new Settings(currentUpdateOriginTime, rotationDate, updatePatchVersion, dataSource, themeType);

    return _settings;
  }

  Future writeSettings(Settings settings) async {
    if (_settings == null) {
      throw new Exception('Settings not read before write');
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (_settings.currentUpdateOriginTime != settings.currentUpdateOriginTime) {
      preferences.setString(pref_keys.update_id, settings.currentUpdateOriginTime.toIso8601String());
    }

    if (_settings.nextRotationDate != settings.nextRotationDate) {
      preferences.setString(pref_keys.next_rotation_date, settings.nextRotationDate.toIso8601String());
    }

    if (_settings.updatePatch != settings.updatePatch) {
      preferences.setString(pref_keys.update_patch, settings.updatePatch);
    }

    if (_settings.dataSource != settings.dataSource) {
      preferences.setString(pref_keys.data_source, settings.dataSource.name);
    }

    if (_settings.themeType != settings.themeType) {
      preferences.setString(pref_keys.theme_type, settings.themeType.name);
    }

    _settings = settings;
  }
}