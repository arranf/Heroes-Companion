import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:heroes_companion_data/src/database/database_upgrades.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:heroes_companion_data/src/providers/hero_provider.dart';

class DatabaseClient {
  static HeroProvider heroProvider;
  static DatabaseClient _client = new DatabaseClient._internal();
  static final String databaseName = "heroes_companion.db";
  static final int databaseVersion = 2;

  factory DatabaseClient() {
    return _client;
  }

  DatabaseClient._internal();

  Future _onCreate(Database database, int version) async {
    // Add our initial set of columns
    await database.execute("""
            ALTER TABLE heroes
            ADD COLUMN IsOwned INTEGER DEFAULT 0
            """);
    await database.execute("""
            ALTER TABLE heroes
            ADD COLUMN IsFavorite INTEGER DEFAULT 0
            """);

    // Migrations
    _onUpgrade(database, 0, 3);
  }

  _onUpgrade(Database database, int oldVersion, int newVersion) async {
    // TODO make this cleaner
    if (oldVersion < 2){
      debugPrint('Upgrading to 2');
      await upgradeTo2(database);
    }

    if (oldVersion < 3) {
      debugPrint('Upgrading to 3');
      await upgradeTo3(database);
    }
  }

  Future<Database> start() async {
    String databasePath = await _getDatabasePath(databaseName);
    return await openDatabase(databasePath, version: databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade );
  }

  /// @param databaseName The name of the database (e.g. heroes.db)
  Future createDatabaseIfNotFound() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);
    if (FileSystemEntity.typeSync(path) != FileSystemEntityType.NOT_FOUND) {
      return;
    }
    debugPrint('Creating Database at ${path}');
    // delete existing if any
    await deleteDatabase(path);

    // Copy from asset
    ByteData data = await rootBundle.load(join("assets", databaseName));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await new File(path).writeAsBytes(bytes);
  }

  Future<String> _getDatabasePath(String databaseName) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    return join(documentsDirectory.path, databaseName);
  }
}