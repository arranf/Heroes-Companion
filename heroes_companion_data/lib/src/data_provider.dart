import 'dart:async';

import 'package:heroes_companion_data/src/database_client.dart';
import 'package:heroes_companion_data/src/providers/ability_provider.dart';
import 'package:heroes_companion_data/src/providers/hero_provider.dart';
import 'package:heroes_companion_data/src/providers/talent_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataProvider {
  static HeroProvider heroProvider;
  static TalentProvider talentProvider;
  static AbilityProvider abilityProvider;
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
  }
}