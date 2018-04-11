import 'package:heroes_companion_data/src/models/ability.dart';
import 'package:heroes_companion_data/src/models/hero.dart';
import 'package:heroes_companion_data/src/models/talent.dart';

class UpdatePayload {
  final DateTime id;
  final String patch;
  final DateTime patch_date;
  final List<Hero> heroes;
  final List<Talent> talents;
  final List<Ability> abilities;

  UpdatePayload(this.id, this.patch_date, this.patch, this.heroes, this.talents,
      this.abilities);

  factory UpdatePayload.fromJson(Map<dynamic, dynamic> json) {
    if (!(json is Map)) {
      throw new Exception('Update Payload: Unexpected JSON format');
    }

    Map<dynamic, dynamic> map = json;
    if (!(map['id'] is String &&
        // map['heroes'] is List<Map> &&
        map['patch'] is String &&
        // map['talents'] is List<Map> &&
        // map['abilities'] is List<Map> &&
        map['patch_date'] is String)) {
      throw new Exception('Update Payload: Unexpected JSON format');
    }

    DateTime id = DateTime.parse(map['id'] as String);
    DateTime patchDate = DateTime.parse(map['patch_date'] as String);
    String patch = map.containsKey('patch') ? map['patch'] : '';

    List<dynamic> heroJson = map['heroes'] as List<dynamic>;
    List<Hero> heroes = heroJson
        .map((h) => new Hero.fromMap(h as Map<dynamic, dynamic>))
        .toList();

    List<dynamic> talentsJson = map['talents'] as List<dynamic>;
    List<Talent> talents = talentsJson
        .map((dynamic t) => new Talent.fromMap(t as Map<dynamic, dynamic>))
        .toList();

    List<dynamic> abilitiesJson = map['abilities'] as List<dynamic>;
    List<Ability> abilities = abilitiesJson
        .map((dynamic a) => new Ability.fromMap(a as Map<dynamic, dynamic>))
        .toList();
    return new UpdatePayload(id, patchDate, patch, heroes, talents, abilities);
  }
}
