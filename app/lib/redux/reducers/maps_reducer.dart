import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';

final mapsReducer = combineReducers<List<PlayableMap>>([
  new TypedReducer<List<PlayableMap>, FetchMapsSucceededAction>(_setMaps),
  new TypedReducer<List<PlayableMap>, FetchMapsFailedAction>(_setNoMaps)
]);

List<PlayableMap> _setMaps(
    List<PlayableMap> maps, FetchMapsSucceededAction action) {
  return action.maps;
}

List<PlayableMap> _setNoMaps(
    List<PlayableMap> maps, FetchMapsFailedAction action) {
  return null;
}
