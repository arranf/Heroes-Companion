import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';


final loadingReducer = combineTypedReducers<bool>([
  new ReducerBinding<bool, GameInfoLoadedAction>(_setLoaded),
  new ReducerBinding<bool, GameInfoNotLoadedAction>(_setLoaded),
]);

bool _setLoaded(bool state, action) {
  return false;
}