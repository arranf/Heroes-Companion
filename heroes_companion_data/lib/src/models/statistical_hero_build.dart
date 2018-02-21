import 'package:heroes_companion_data/src/api/DTO/hots_log_builds.dart';
import 'package:heroes_companion_data/src/models/hero_build.dart';
import 'package:hots_dog_api/hots_dog_api.dart';
import 'package:meta/meta.dart';

class StatisticalHeroBuild {
  final HeroBuild build;
  final int gamesPlayed;
  final double winRate;
  final String label;

  StatisticalHeroBuild({@required this.build, @required this.gamesPlayed, @required this.winRate, this.label});


  factory StatisticalHeroBuild.fromBuildStatistics(BuildStatistics buildStatistics, int heroId, String label) {
    HeroBuild build = new HeroBuild(heroId, buildStatistics.talents_names);
    // The cast below is because sometimes winrates are ints and sometimes they are doubles
    return new StatisticalHeroBuild(build: build, gamesPlayed: buildStatistics.total_games_played, winRate: double.parse(buildStatistics.win_rate.toString()), label: label);
  }

  factory StatisticalHeroBuild.fromHotsLogBuild(HotsLogBuild hotsLogBuild, int heroId) {
    HeroBuild build = new HeroBuild(heroId, hotsLogBuild.talentNames);
    return new StatisticalHeroBuild(build: build, gamesPlayed: hotsLogBuild.gamesPlayed, winRate: hotsLogBuild.winPercentage / 100); 
  }
}