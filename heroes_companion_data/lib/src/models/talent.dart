import 'package:heroes_companion_data/src/tables/talent_table.dart' as table;

class Talent {
  final int id;
  final int hero_id;
  final String ability_id;
  final String talent_tree_id;
  final String tool_tip_id;
  final int level;
  final int sort_order;
  final String name;
  final String description;
  final String icon_file_name;
  final String sha3_256;

  Talent(
      this.id,
      this.hero_id,
      this.ability_id,
      this.talent_tree_id,
      this.tool_tip_id,
      this.level,
      this.sort_order,
      this.name,
      this.description,
      this.icon_file_name,
      this.sha3_256);

  factory Talent.fromMap(Map map) {
    int id = map[table.column_id];
    int hero_id = map[table.column_hero_id];
    String ability_id = map[table.column_ability_id];
    String talent_tree_id = map[table.column_talent_tree_id];
    String tool_tip_id = map[table.column_tool_tip_id];
    int level = map[table.column_level];
    int sort_order = map[table.column_sort_order];
    String name = map[table.column_name];
    String description = map[table.column_description];
    String icon_file_name = map[table.column_icon_file_name];
    String sha3_256 = map[table.column_sha3_256];
    return new Talent(id, hero_id, ability_id, talent_tree_id, tool_tip_id,
        level, sort_order, name, description, icon_file_name, sha3_256);
  }

  Map toMap() {
    Map map = {
      table.column_id: id,
      table.column_hero_id: hero_id,
      table.column_ability_id: ability_id,
      table.column_talent_tree_id: talent_tree_id,
      table.column_tool_tip_id: tool_tip_id,
      table.column_level: level,
      table.column_sort_order: sort_order,
      table.column_name: name,
      table.column_description: description,
      table.column_icon_file_name: icon_file_name,
      table.column_sha3_256: sha3_256
    };
    return map;
  }

  Map toUpdateMap() {
    Map map = toMap();
    map.remove(table.column_id);
    return map;
  }

  Talent copyWith(
      {int id,
      int hero_id,
      String ability_id,
      String talent_tree_id,
      String tool_tip_id,
      int level,
      int sort_order,
      String name,
      String description,
      String icon_file_name,
      String sha3_256}) {
    return new Talent(
      id = id ?? this.id,
      hero_id = hero_id ?? this.hero_id,
      ability_id = ability_id ?? this.ability_id,
      talent_tree_id = talent_tree_id ?? this.talent_tree_id,
      tool_tip_id = tool_tip_id ?? this.tool_tip_id,
      level = level ?? this.level,
      sort_order = sort_order ?? this.sort_order,
      name = name ?? this.name,
      description = description ?? this.description,
      icon_file_name = icon_file_name ?? this.icon_file_name,
      sha3_256 = sha3_256 ?? this.sha3_256,
    );
  }

  @override
  String toString() {
    return 'Talent ${name}';
  }

  @override
  int get hashCode {
    return this.hero_id.hashCode ^
        this.ability_id.hashCode ^
        this.talent_tree_id.hashCode ^
        this.tool_tip_id.hashCode ^
        this.level.hashCode ^
        this.name.hashCode ^
        this.description.hashCode ^
        this.icon_file_name.hashCode;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Talent &&
          this.hero_id == other.hero_id &&
          this.ability_id == other.ability_id &&
          this.talent_tree_id == other.talent_tree_id &&
          this.tool_tip_id == other.tool_tip_id &&
          this.level == other.level &&
          this.name == other.name &&
          this.description == other.description &&
          this.icon_file_name == other.icon_file_name;
}
