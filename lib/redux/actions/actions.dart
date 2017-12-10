import 'package:hots_dog_api/hots_dog_api.dart';

class LoadGameInfoAction {}

class GameInfoNotLoadedAction {}

class GameInfoLoadedAction {
  final GameInfo gameInfo;

  GameInfoLoadedAction(this.gameInfo);
}