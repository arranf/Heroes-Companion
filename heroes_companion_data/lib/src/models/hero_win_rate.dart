import 'package:heroes_companion_data/src/tables/win_rate_table.dart' as table;

class HeroWinRate {
  final int id;
  final int heroId; // This joins on the hero table's column_hero_id
  final double winPercentage;

  HeroWinRate(this.heroId, this.winPercentage, {this.id});


  factory HeroWinRate.fromMap(Map map) {
    int id = map[table.column_id];
    int heroId = map[table.column_hero_id];
    double winPercentage = map[table.column_percentage];
    return new HeroWinRate(heroId, winPercentage, id: id);
  }

  Map toMap() {
    Map map = {
      table.column_id: id,
      table.column_hero_id: heroId,
      table.column_percentage: winPercentage,
    };
    return map;
  }

}