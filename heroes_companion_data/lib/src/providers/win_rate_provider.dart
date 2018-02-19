import 'dart:async';
import 'package:heroes_companion_data/src/data_provider.dart';
import 'package:heroes_companion_data/src/models/hero_win_rate.dart';
import 'package:hots_dog_api/hots_dog_api.dart' as api;
import 'package:hots_dog_api/hots_dog_api.dart';

class WinRateProvider {
  Future<List<HeroWinRate>> getWinRates(String buildNumber) async {
    api.WinRates hotsDogWinRates = await api.getWinRates(buildNumber);
    List<Future> futures =  new List();
    hotsDogWinRates.current.forEach((String heroName, WinLossCount winLossCount) {
      futures.add(_getHeroIdForName(winLossCount, heroName));
    });

    List<HeroWinRate> heroWinRates = await Future.wait(futures);

    if (hotsDogWinRates == null) {
      throw new Exception('API call to fetch builds failed');
    }
    return heroWinRates;
  }

  Future<HeroWinRate> _getHeroIdForName(api.WinLossCount winLossCount, String heroName) async {
    int heroId = await DataProvider.heroProvider.getHeroIdByName(heroName);
    return new HeroWinRate.fromWinLossCount(winLossCount, heroId);
  }
}
