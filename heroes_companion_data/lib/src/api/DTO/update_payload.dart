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

  factory UpdatePayload.fromJson(Object json) {
    if (!(json is Map)) {
      throw new Exception('Unexpected JSON format');
    }

    Map map = json;
    if (!(map['id'] is String &&
        map['heroes'] is List<Map> &&
        map['patch'] is String &&
        map['talents'] is List<Map> &&
        map['abilities'] is List<Map> &&
        map['patch_date'] is String)) {
      throw new Exception('Unexpected JSON format');
    }

    DateTime id = DateTime.parse(map['id']);
    DateTime patchDate = DateTime.parse(map['patch_date']);
    List<Hero> heroes = map['heroes'].map((h) => new Hero.fromMap(h)).toList();
    String patch = map.containsKey('patch') ? map['patch'] : '';
    List<Talent> talents =
        map['talents'].map((Map t) => new Talent.fromMap(t)).toList();
    List<Ability> abilities =
        map['abilities'].map((Map a) => new Ability.fromMap(a)).toList();
    return new UpdatePayload(id, patchDate, patch, heroes, talents, abilities);
  }
}
