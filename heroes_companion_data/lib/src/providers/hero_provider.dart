import 'dart:async';
import 'package:flutter/foundation.dart';

import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:heroes_companion_data/src/api/DTO/rotation_data.dart';
import 'package:heroes_companion_data/src/api/api.dart';
import 'package:heroes_companion_data/src/models/settings.dart';
import 'package:sqflite/sqflite.dart';
import 'package:heroes_companion_data/src/models/hero.dart';
import 'package:heroes_companion_data/src/tables/hero_table.dart' as hero_table;

class HeroProvider {
  Database _database;
  HeroProvider(this._database);

  Future<Hero> getHeroByHeroesCompanionId(int id) {
    return new Future.sync(() async {
      List<Map> maps = await _database.query(hero_table.table_name,
          columns: null,
          where: "${hero_table.column_heroes_companion_hero_id} = ?",
          whereArgs: [id]);
      if (maps.length > 0) {
        return new Hero.fromMap(maps.first);
      }
      return null;
    });
  }

  Future<Hero> getHeroByHeroId(int id) {
    return new Future.sync(() async {
      List<Map> maps = await _database.query(hero_table.table_name,
          columns: null,
          where: "${hero_table.column_hero_id} = ?",
          whereArgs: [id]);
      if (maps.length > 0) {
        return new Hero.fromMap(maps.first);
      }
      return null;
    });
  }

  Future<int> getHeroIdByName(String heroName) {
    return new Future.sync(() async {
      List<Map> maps = await _database.query(hero_table.table_name,
          columns: [hero_table.column_hero_id],
          where: "${hero_table.column_name} = ?",
          whereArgs: [heroName]);
      if (maps.length > 0) {
        return maps.first[hero_table.column_hero_id];
      }
      return null;
    });
  }

  Future<List<Hero>> getHeroes() {
    return new Future.sync(() async {
      List<Map> maps = await _database.query(hero_table.table_name,
          columns: null, orderBy: "${hero_table.column_name} ASC");

      if (maps.length > 0) {
        List<Hero> heroes = maps.map((h) => new Hero.fromMap(h)).toList();
        await Future.wait(heroes.map((Hero hero) async {
          hero.talents =
              await DataProvider.talentProvider.getTalentsForHero(hero.hero_id);
        }));
        return heroes;
      } else {
        throw new Exception('No heroes found');
      }
    });
  }

  Future<List<Hero>> getFavoriteHeroes() {
    return new Future.sync(() async {
      List<Map> maps = await _database.query(hero_table.table_name,
          columns: null,
          orderBy: "date(${hero_table.column_release_date}) DESC",
          where: "${hero_table.column_is_favorite} = 1");

      if (maps.length > 0) {
        return new List.generate(
            maps.length, (int index) => new Hero.fromMap(maps[index]));
      }
      return null;
    });
  }

  Future updateHeroRotations({isForced = false}) {
    return new Future.sync(() async {
      Settings settings = await DataProvider.settingsProvider.readSettings();

      // is forced or the date is before the next rotation date, this will be skipped
      if (!isForced && !new DateTime.now().isAfter(settings.nextRotationDate)) {
        debugPrint(
            'Rotation Updater: ${new DateTime.now()} is before ${settings.nextRotationDate}, not updating');
        return;
      }

      RotationData data = await getRotation();
      // TODO Validation of data
      //
      RegExp regExp = new RegExp(r'[^A-Za-z]+');
      String commaSeparatedHeroes = data.heroes
          // Non alphanumeric characters become the empty string
          .map((a) {
        return '\'' + a.replaceAll(regExp, '').toLowerCase() + '\'';
      }).join(',');

      await _database.rawUpdate('''
          UPDATE ${hero_table.table_name}
          SET ${hero_table.column_last_rotation_date} = '${data.rotationEnd.toIso8601String()}'
          WHERE ${hero_table.column_short_name} IN (${commaSeparatedHeroes})
          ''');
      settings.copyWith(nextRotationDate: data.rotationEnd);
      DataProvider.settingsProvider.writeSettings(settings);
    });
  }

  Future<int> update(Hero hero) async {
    return await _database.update(hero_table.table_name, hero.toMap(),
        where: "${hero_table.column_heroes_companion_hero_id} = ?",
        whereArgs: [hero.heroes_companion_hero_id]);
  }
}
