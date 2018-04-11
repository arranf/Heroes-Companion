import 'package:heroes_companion_data/src/models/ability.dart';
import 'package:heroes_companion_data/src/models/talent.dart';
import 'package:heroes_companion_data/src/tables/hero_table.dart' as table;

class Hero {
  final int heroes_companion_hero_id;
  final int hero_id;
  final String name;
  final String short_name;
  final String attribute_id;
  final String icon_file_name;
  final String role;
  final String type;
  final DateTime release_date;
  final String sha3_256;
  List<Talent> talents;
  List<Ability> abilities;
  final bool is_owned;
  bool is_favorite;
  DateTime last_rotation_date = new DateTime(1970);
  DateTime last_modified = new DateTime(1970);
  bool have_assets = false;
  final String additional_search_text;

  Hero(
    this.heroes_companion_hero_id,
    this.hero_id,
    this.name,
    this.short_name,
    this.attribute_id,
    this.icon_file_name,
    this.role,
    this.type,
    this.release_date,
    this.is_owned,
    this.is_favorite,
    this.have_assets,
    this.sha3_256,
    this.additional_search_text, {
    this.talents,
    this.abilities,
    this.last_rotation_date,
    this.last_modified,
  });

  factory Hero.fromMap(Map<dynamic, dynamic> map) {
    int heroes_companion_hero_id = map[table.column_heroes_companion_hero_id];
    int hero_id = map[table.column_hero_id];
    String name = map[table.column_name];
    String short_name = map[table.column_short_name];
    String attribute_id = map[table.column_attribute_id];
    String hero_icon_file_name = map[table.column_icon_file_name];
    String role = map[table.column_role];
    String type = map[table.column_type];
    DateTime release_date = DateTime.parse(map[table.column_release_date] as String);
    bool is_owned = map[table.column_is_owned] == 1;
    bool is_favorite = map[table.column_is_favorite] == 1;
    DateTime last_rotation_date = map[table.column_last_rotation_date] == null
        ? new DateTime(1970)
        : DateTime.parse(map[table.column_last_rotation_date] as String);
    bool have_assets = map[table.column_have_assets] == 1;
    String sha3_256 = map[table.column_sha3_256];
    String additional_search_text = map[table.column_additional_search_text];
    String modified = map[table.column_modified_date];
    DateTime last_modified = modified != null && modified.isNotEmpty
        ? DateTime.parse(modified)
        : new DateTime(1970);
    return new Hero(
      heroes_companion_hero_id,
      hero_id,
      name,
      short_name,
      attribute_id,
      hero_icon_file_name,
      role,
      type,
      release_date,
      is_owned,
      is_favorite,
      have_assets,
      sha3_256,
      additional_search_text,
      last_rotation_date: last_rotation_date,
      last_modified: last_modified,
    );
  }

  bool isOnRotation() {
    return last_rotation_date.compareTo(new DateTime.now()) == 1;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      table.column_heroes_companion_hero_id: heroes_companion_hero_id,
      table.column_hero_id: hero_id,
      table.column_name: name,
      table.column_short_name: short_name,
      table.column_attribute_id: attribute_id,
      table.column_icon_file_name: icon_file_name,
      table.column_role: role,
      table.column_type: type,
      table.column_release_date: release_date.toIso8601String(),
      table.column_is_owned: is_owned == true ? 1 : 0,
      table.column_is_favorite: is_favorite == true ? 1 : 0,
      table.column_last_rotation_date: last_rotation_date.toIso8601String(),
      table.column_have_assets: have_assets == true ? 1 : 0,
      table.column_sha3_256: sha3_256,
      table.column_additional_search_text: additional_search_text,
      table.column_modified_date:
          last_modified == null ? null : last_modified.toIso8601String(),
    };
    return map;
  }

  Map<String, dynamic> toUpdateMap() {
    Map<String, dynamic> map = toMap();
    map.remove(table.column_heroes_companion_hero_id);
    map.remove(table.column_is_owned);
    map.remove(table.column_is_favorite);
    map.remove(table.column_last_rotation_date);
    map.remove(table.column_have_assets);
    // We don't need additional search text to be updatable
    map.remove(table.column_additional_search_text);
    map[table.column_modified_date] = new DateTime.now().toIso8601String();
    return map;
  }

  Hero copyWith({
    int heroes_companion_hero_id,
    int hero_id,
    String name,
    String short_name,
    String attribute_id,
    String icon_file_name,
    String role,
    String type,
    DateTime release_date,
    bool is_owned,
    bool is_favorite,
    bool have_assets,
    List<Talent> talents,
    List<Ability> abilities,
    DateTime last_rotation_date,
    String sha3_256,
    String additional_search_text,
    DateTime last_modified,
  }) {
    return new Hero(
      heroes_companion_hero_id =
          heroes_companion_hero_id ?? this.heroes_companion_hero_id,
      hero_id = hero_id ?? this.hero_id,
      name = name ?? this.name,
      short_name = short_name ?? this.short_name,
      attribute_id = attribute_id ?? this.attribute_id,
      icon_file_name = icon_file_name ?? this.icon_file_name,
      role = role ?? this.role,
      type = type ?? this.type,
      release_date = release_date ?? this.release_date,
      is_owned = is_owned ?? this.is_owned,
      is_favorite = is_favorite ?? this.is_favorite,
      have_assets = have_assets ?? this.have_assets,
      sha3_256 = sha3_256 ?? this.sha3_256,
      additional_search_text =
          additional_search_text ?? this.additional_search_text,
      talents: talents ?? this.talents,
      abilities: abilities ?? this.abilities,
      last_rotation_date: last_rotation_date ?? this.last_rotation_date,
      last_modified: last_modified ?? this.last_modified,
    );
  }

  @override
  String toString() {
    return "${name}";
  }
}
