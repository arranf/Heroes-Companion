import 'dart:async';
import 'package:hots_dog_api/hots_dog_api.dart' as api;

class GameInfoProvider {
  Future<api.GameInfo> getGameInfo() {
    return api.getGameInfo();
  }

  Future<List<api.BuildInfo>> getBuilds() async {
    api.GameInfo gameinfo = await getGameInfo();
    return gameinfo.buildInfo;
  }
}