import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';

final mapsReducer = combineTypedReducers<List<PlayableMap>>([
  new ReducerBinding<List<PlayableMap>, FetchMapsSucceededAction>(
      _setMaps),
  new ReducerBinding<List<PlayableMap>, FetchMapsFailedAction>(_setNoMaps)
]);

List<PlayableMap> _setMaps(
    List<PlayableMap> maps, FetchMapsSucceededAction action) {
  return action.maps;
}

List<PlayableMap> _setNoMaps(List<PlayableMap> maps, FetchMapsFailedAction action) {
  return null;
}