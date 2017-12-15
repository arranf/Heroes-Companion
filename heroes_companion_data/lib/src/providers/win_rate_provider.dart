import 'dart:async';
import 'package:hots_dog_api/hots_dog_api.dart' as api;
import 'package:hots_dog_api/hots_dog_api.dart';

class WinRateProvider {
  Future<api.WinRates> getWinRates(String buildNumber) async {
    WinRates winRates = await api.getWinRates(buildNumber);
    if (winRates == null) {
      throw new Exception('API call to fetch builds failed');
    }
    return winRates;
  }
}