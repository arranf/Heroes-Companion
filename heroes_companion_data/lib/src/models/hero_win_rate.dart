import 'package:heroes_companion_data/src/tables/win_rate_table.dart' as table;
import 'package:hots_dog_api/hots_dog_api.dart';

class HeroWinRate {
  final int id;
  final int heroId; // This joins on the hero table's column_hero_id
  final double winPercentage;
  final int gamesPlayed;

  HeroWinRate(this.heroId, this.winPercentage, this.gamesPlayed, {this.id});

  factory HeroWinRate.fromMap(Map map) {
    int id = map[table.column_id];
    int heroId = map[table.column_hero_id];
    double winPercentage = map[table.column_percentage];
    int gamesPlayed = map[table.column_games_played];
    return new HeroWinRate(heroId, winPercentage, gamesPlayed, id: id);
  }

  factory HeroWinRate.fromWinLossCount(WinLossCount winLossCount, int heroId) {
    //TODO change winLossCount.wins to int
    return new HeroWinRate(heroId, winLossCount.winPercentange().toDouble(),
        winLossCount.wins.toInt() + winLossCount.losses.toInt());
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
