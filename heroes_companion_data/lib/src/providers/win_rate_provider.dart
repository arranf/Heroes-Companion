import 'dart:async';
import 'package:heroes_companion_data/src/api/DTO/hots_log_winrate.dart';
import 'package:heroes_companion_data/src/api/api.dart';
import 'package:heroes_companion_data/src/data_provider.dart';
import 'package:heroes_companion_data/src/models/data_source.dart';
import 'package:heroes_companion_data/src/models/hero_win_rate.dart';
import 'package:heroes_companion_data/src/models/patch.dart';
import 'package:heroes_companion_data/src/models/settings.dart';
import 'package:hots_dog_api/hots_dog_api.dart' as api;

class WinRateProvider {
  Future<List<HeroWinRate>> getWinRates(Patch patch) async {
    Settings settings = await DataProvider.settingsProvider.readSettings();
    if (settings.dataSource == DataSource.HotsDog) {
      return _hotsDogGetWinRates(patch);
    } else {
      return _hotsLogsGetWinRates(patch);
    }
  }

  Future<HeroWinRate> _getHeroWinRateFromWinLossCount(
      api.WinLossCount winLossCount, String heroName) async {
    int heroId = await DataProvider.heroProvider.getHeroIdByName(heroName);
    return new HeroWinRate.fromWinLossCount(winLossCount, heroId);
  }

  Future<HeroWinRate> _getHeroWinRateFromHotsLogWinRate(
      HotsLogsWinrate hotsLogsWinrate) async {
    int heroId =
        await DataProvider.heroProvider.getHeroIdByName(hotsLogsWinrate.name);
    return new HeroWinRate(
        heroId, hotsLogsWinrate.winPercentage, hotsLogsWinrate.gamesPlayed);
  }

  Future<List<HeroWinRate>> _hotsLogsGetWinRates(Patch patch) async {
    List<HotsLogsWinrate> winRates = await getHotsLogWinRates(patch);

    if (winRates == null) {
      throw new Exception('API call to fetch hots log winrates failed');
    }
    List<Future<HeroWinRate>> futures = new List();
    winRates.forEach((HotsLogsWinrate hotsLogsWinrate) {
      futures.add(_getHeroWinRateFromHotsLogWinRate(hotsLogsWinrate));
    });

    List<HeroWinRate> heroWinRates = await Future.wait(futures);

    return heroWinRates;
  }

  Future<List<HeroWinRate>> _hotsDogGetWinRates(Patch patch) async {
    api.WinRates hotsDogWinRates = await api.getWinRates(patch.hotsDogId);

    if (hotsDogWinRates == null) {
      throw new Exception('API call to fetch hots dog hero winrates failed');
    }

    List<Future<HeroWinRate>> futures = new List();
    hotsDogWinRates.current
        .forEach((String heroName, api.WinLossCount winLossCount) {
      futures.add(_getHeroWinRateFromWinLossCount(winLossCount, heroName));
    });

    List<HeroWinRate> heroWinRates = await Future.wait(futures);

    return heroWinRates;
  }
}
