import 'dart:async';
import 'package:hots_dog_api/hots_dog_api.dart' as api;

class WinRateProvider {
  Future<api.WinRates> getWinRates(String buildNumber) {
    return api.getWinRates(buildNumber);
  }
}