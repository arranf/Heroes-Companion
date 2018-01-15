import 'dart:async';
import 'package:hots_dog_api/hots_dog_api.dart' as api;

class GameInfoProvider {
  Future<api.GameInfo> getGameInfo() async {
    api.GameInfo gameInfo = await api.getGameInfo();
    if (gameInfo == null) {
      throw new Exception('API call to fetch builds failed');
    }
    return gameInfo;
  }

  Future<List<api.BuildInfo>> getBuilds() async {
    api.GameInfo gameInfo = await getGameInfo();
    if (gameInfo == null) {
      throw new Exception('API call to fetch builds failed');
    }
    return gameInfo.buildInfo;
  }
}
