import 'dart:async';
import 'package:hots_dog_api/hots_dog_api.dart' as api;

class BuildWinRatesProvider {
  Future<api.BuildWinRates> getBuildWinRates(
      String buildNumber, String heroName) {
    return new Future.sync(() async {
      api.BuildWinRates buildWinRates =
          await api.getBuildWinRates(buildNumber, heroName);
      if (buildWinRates == null) {
        throw new Exception('API call to fetch builds failed');
      }
      return buildWinRates;
    });
  }
}
