import 'package:heroes_companion_data/src/tables/ability_table.dart' as table;

class Ability {
  final int id;
  final int hero_id;
  final String ability_id;
  final String character_form;
  final String name;
  final String description;
  final String hotkey;
  final String cooldown;
  final String mana_cost;
  final bool trait;
  final String sha3_256;

  Ability(
    this.id,
    this.hero_id,
    this.ability_id,
    this.character_form,
    this.name,
    this.description,
    this.hotkey,
    this.cooldown,
    this.mana_cost,
    this.trait,
    this.sha3_256,
  );

  factory Ability.fromMap(Map map) {
    int id = map[table.column_id];
    int hero_id = map[table.column_hero_id];
    String ability_id = map[table.column_ability_id];
    String character_form = map[table.column_character_form];
    String name = map[table.column_name];
    String description = map[table.column_description];
    String hotkey = map[table.column_hotkey];
    String cooldown = map[table.column_cooldown];
    String mana_cost = map[table.column_mana_cost];
    bool trait = map[table.column_trait] == 0 ? false : true;
    String sha3_256 = map[table.column_sha3_256];
    return new Ability(id, hero_id, ability_id, character_form, name,
        description, hotkey, cooldown, mana_cost, trait, sha3_256);
  }

  Map toMap() {
    Map map = {
      table.column_id: id,
      table.column_hero_id: hero_id,
      table.column_ability_id: ability_id,
      table.column_character_form: character_form,
      table.column_name: name,
      table.column_description: description,
      table.column_hotkey: hotkey,
      table.column_cooldown: cooldown,
      table.column_mana_cost: mana_cost,
      table.column_trait: trait,
      table.column_sha3_256: sha3_256,
    };
    return map;
  }

  Map toUpdateMap() {
    Map map = toMap();
    map.remove(table.column_id);
    return map;
  }

  Ability copyWith({
    int id,
    int hero_id,
    String ability_id,
    String character_form,
    String name,
    String description,
    String hotkey,
    String cooldown,
    String mana_cost,
    bool trait,
    String sha3_256,
  }) {
    return new Ability(
        id = id ?? this.id,
        hero_id = hero_id ?? this.hero_id,
        ability_id = ability_id ?? this.ability_id,
        character_form = character_form ?? this.character_form,
        name = name ?? this.name,
        description = description ?? this.description,
        hotkey = hotkey ?? this.hotkey,
        cooldown = cooldown ?? this.cooldown,
        mana_cost = mana_cost ?? this.mana_cost,
        trait = trait ?? this.trait,
        sha3_256 = sha3_256 ?? this.sha3_256);
  }
}
