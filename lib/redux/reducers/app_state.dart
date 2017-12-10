import 'package:heroes_companion/redux/reducers/is_loading.dart';
import 'package:heroes_companion/redux/reducers/game_info.dart';
import 'package:heroes_companion/redux/state.dart';

// We create the State reducer by combining many smaller reducers into one!
AppState appReducer(AppState state, action) {
  return new AppState(
    isLoading: loadingReducer(state.isLoading, action),
    gameInfo: gameInfoReducer(state.gameInfo, action)
  );
}