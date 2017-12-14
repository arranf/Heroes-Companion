import 'package:heroes_companion/redux/reducers/is_loading.dart';
import 'package:heroes_companion/redux/reducers/heroes_reducer.dart';
import 'package:heroes_companion/redux/reducers/build_info.dart';
import 'package:heroes_companion/redux/state.dart';

// We create the State reducer by combining many smaller reducers into one!
AppState appReducer(AppState state, action) {
  return new AppState(
    isLoading: loadingReducer(state.isLoading, action),
    heroes: heroesReducer(state.heroes, action),
    buildInfo: buildInfoReducer(state.buildInfo, action)
  );
}