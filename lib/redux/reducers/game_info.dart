import 'package:hots_dog_api/hots_dog_api.dart';
import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';

final gameInfoReducer = combineTypedReducers<GameInfo>([
  new ReducerBinding<GameInfo, GameInfoLoadedAction>(_setLoadedGameInfo),
  new ReducerBinding<GameInfo, GameInfoNotLoadedAction>(_setNoGameInfo),
]);

GameInfo _setLoadedGameInfo(GameInfo gameInfo, GameInfoLoadedAction action) {
  return action.gameInfo;
}

GameInfo _setNoGameInfo(GameInfo gameInfo, GameInfoNotLoadedAction action) {
  return null;
}