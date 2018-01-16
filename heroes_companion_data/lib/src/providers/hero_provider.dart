import 'dart:async';
import 'package:flutter/foundation.dart';


import 'package:shared_preferences/shared_preferences.dart';
import 'package:heroes_companion_data/src/shared_preferences_keys.dart'
    as pref_keys;

import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:heroes_companion_data/src/api/DTO/heroes_companion_data.dart';
import 'package:heroes_companion_data/src/api/api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:heroes_companion_data/src/models/hero.dart';
import 'package:heroes_companion_data/src/tables/hero_table.dart' as hero_table;

class HeroProvider {
  Database _database;
  HeroProvider(this._database);

  Future<Hero> getHeroByHeroesCompanionId(int id) async {
    List<Map> maps = await _database.query(hero_table.table_name,
        columns: null,
        where: "${hero_table.column_heroes_companion_hero_id} = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return new Hero.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Hero>> getHeroes() async {
    List<Map> maps = await _database.query(hero_table.table_name,
        columns: null, orderBy: "${hero_table.column_name} ASC");

    if (maps.length > 0) {
      List<Hero> heroes = maps.map((h) => new Hero.fromMap(h));
      await heroes.forEach((hero) async {
        //    hero.abilities = await DataProvider.abilityProvider.getAbilitiesForHero(hero.hero_id);
        hero.talents =
            await DataProvider.talentProvider.getTalentsForHero(hero.hero_id);
      });
      return heroes;
    } else {
      throw new Exception('No heroes found');
    }
  }

  Future<List<Hero>> getFavoriteHeroes() async {
    List<Map> maps = await _database.query(hero_table.table_name,
        columns: null,
        orderBy: "date(${hero_table.column_release_date}) DESC",
        where: "${hero_table.column_is_favorite} = 1");

    if (maps.length > 0) {
      return new List.generate(
          maps.length, (int index) => new Hero.fromMap(maps[index]));
    }
    return null;
  }

  Future updateHeroRotations() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String unparsedNextRotationDate = (preferences.getString(pref_keys.next_rotation_date) ?? '');
    DateTime nextRotationDate =
        unparsedNextRotationDate == '' ? new DateTime(1970) : DateTime.parse(unparsedNextRotationDate);
    
    if (!new DateTime.now().isAfter(nextRotationDate)){
      return;
    }

    HeroesCompanionData data = await getRotation();
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

    preferences.setString(pref_keys.next_rotation_date, data.rotationEnd.toIso8601String());
  }

  Future<int> update(Hero hero) async {
    return await _database.update(hero_table.table_name, hero.toMap(),
        where: "${hero_table.column_heroes_companion_hero_id} = ?",
        whereArgs: [hero.heroes_companion_hero_id]);
  }
}
