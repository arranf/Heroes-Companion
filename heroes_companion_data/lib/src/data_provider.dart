import 'dart:async';

import 'package:heroes_companion_data/src/database/database_client.dart';
import 'package:heroes_companion_data/src/providers/ability_provider.dart';
import 'package:heroes_companion_data/src/providers/builds_provider.dart';
import 'package:heroes_companion_data/src/providers/hero_provider.dart';
import 'package:heroes_companion_data/src/providers/map_provider.dart';
import 'package:heroes_companion_data/src/providers/patch_provider.dart';
import 'package:heroes_companion_data/src/providers/settings_provider.dart';
import 'package:heroes_companion_data/src/providers/talent_provider.dart';
import 'package:heroes_companion_data/src/providers/update_provider.dart';
import 'package:heroes_companion_data/src/providers/win_rate_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataProvider {
  static HeroProvider heroProvider;
  static TalentProvider talentProvider;
  static AbilityProvider abilityProvider;
  static WinRateProvider winRateProvider = new WinRateProvider();
  static SettingsProvider settingsProvider = new SettingsProvider();
  static PatchProvider patchProvider;
  static BuildProvider buildProvider = new BuildProvider();
  static UpdateProvider updateProvider;
  static MapProvider mapProvider;
  static Database _database;

  // Singleton
  static final DataProvider _dataProvider = new DataProvider._internal();

  factory DataProvider() => _dataProvider;

  DataProvider._internal();

  static Future start() async {
    await new DatabaseClient().createDatabaseIfNotFound();
    _database = await new DatabaseClient().start();
    heroProvider = new HeroProvider(_database);
    talentProvider = new TalentProvider(_database);
    abilityProvider = new AbilityProvider(_database);
    updateProvider = new UpdateProvider(_database);
    patchProvider = new PatchProvider(_database);
    mapProvider = new MapProvider(_database);
  }
}
