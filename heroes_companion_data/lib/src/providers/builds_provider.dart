import 'dart:async';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:heroes_companion_data/src/api/DTO/build.dart';
import 'package:heroes_companion_data/src/api/DTO/hots_log_builds.dart';
import 'package:heroes_companion_data/src/api/api.dart';
import 'package:heroes_companion_data/src/models/patch.dart';
import 'package:heroes_companion_data/src/models/statistical_hero_build.dart';
import 'package:hots_dog_api/hots_dog_api.dart';

class BuildProvider {
  Future<List<StatisticalHeroBuild>> getStatisticalBuilds(Patch patch, String heroName) async {
    Settings settings = await DataProvider.settingsProvider.readSettings();

    int heroId = await DataProvider.heroProvider.getHeroIdByName(heroName);
    if (settings.dataSource == DataSource.HotsDog) {
      return _getHotsDogStatisticalBuilds(patch, heroName, heroId);
    } else if (settings.dataSource == DataSource.HotsLogs) {
      return _getHotsLogsStatisticalBuilds(patch, heroName, heroId);
    }
    return null;
  }

  Future<List<StatisticalHeroBuild>> _getHotsLogsStatisticalBuilds(Patch patch, String heroName, int heroId) {
    return new Future.sync(() async {
      List<HotsLogBuild> hotslogsBuilds = await getHotsLogBuilds(patch, heroName);
      if (hotslogsBuilds == null) {
        throw new Exception('API call to fetch hotslogs builds failed');
      }
      return hotslogsBuilds.map((b) => new StatisticalHeroBuild.fromHotsLogBuild(b, heroId)).toList();
    });
  }

  Future<List<StatisticalHeroBuild>> _getHotsDogStatisticalBuilds(Patch patch, String heroName, int heroId) {
    return new Future.sync(() async {
      BuildWinRates buildWinRates = await getBuildWinRates(patch.hotsDogId, heroName);
      if (buildWinRates == null) {
        throw new Exception('API call to fetch hotsdog builds failed');
      }
      List<StatisticalHeroBuild> heroBuilds = [];
      if (buildWinRates.winning_builds != null) {
        heroBuilds.addAll(buildWinRates.winning_builds.map((BuildStatistics b) => new StatisticalHeroBuild.fromBuildStatistics(b, heroId, 'Winning Build')));
      }
      if (buildWinRates.winning_builds != null) {
        heroBuilds.addAll(buildWinRates.popular_builds.map((BuildStatistics b) => new StatisticalHeroBuild.fromBuildStatistics(b, heroId, 'Popular Build')));
      }
      return heroBuilds;
    });
  }

  Future<List<Build>> getRegularBuilds(Patch patch, int heroId) async {
    return new Future.sync(() async {
      List<Build> builds = await getBuildsForHero(heroId);
      if (builds == null) {
        throw new Exception('API call to fetch (regular) builds failed');
      }
      return builds;
    });
  }
}
