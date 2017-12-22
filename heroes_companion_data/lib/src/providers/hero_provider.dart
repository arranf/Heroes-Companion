import 'dart:async';
import 'package:flutter/foundation.dart';

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
    List<Map> maps = await _database.query(
      hero_table.table_name,
      columns: null,
      orderBy: "${hero_table.column_name} ASC"
    );
    
    if (maps.length > 0) {
      List<Hero> heroes = new List.generate(maps.length, (int index ) => new Hero.fromMap(maps[index]));
      await heroes.forEach( (hero) async {
      //    hero.abilities = await DataProvider.abilityProvider.getAbilitiesForHero(hero.hero_id);
         hero.talents = await DataProvider.talentProvider.getTalentsForHero(hero.hero_id);
      });
      return heroes; 
    }
    return null;
  }

  Future<List<Hero>> getFavoriteHeroes() async {
    List<Map> maps = await _database.query(
      hero_table.table_name,
      columns: null,
      orderBy: "date(${hero_table.column_release_date}) DESC",
      where: "${hero_table.column_is_favorite} = 1"
    );

    if (maps.length > 0){
      return new List.generate(maps.length, (int index ) => new Hero.fromMap(maps[index]));
    }
    return null;
  }

  updateHeroRotations() async {
    HeroesCompanionData data = await getData();
    await _database.update(
      hero_table.table_name,
      {hero_table.column_last_rotation_date: data.rotationEnd},
      where: "${hero_table.column_name} IN ?",
      whereArgs: data.heroes
    );
  }

  Future<int> update(Hero hero) async {
    return await _database.update(hero_table.table_name, hero.toMap(),
        where: "${hero_table.column_heroes_companion_hero_id} = ?", whereArgs: [hero.heroes_companion_hero_id]);
  }
}