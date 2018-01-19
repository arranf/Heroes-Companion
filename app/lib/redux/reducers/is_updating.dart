import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';

final isUpdatingloadingReducer = combineTypedReducers<bool>([
  new ReducerBinding<bool, StartUpdatingAction>(_setNotLoaded),
  new ReducerBinding<bool, StopUpdatingAction>(_setLoaded),
]);

bool _setLoaded(bool state, action) {
  return false;
}

bool _setNotLoaded(bool state, action) {
  return true;
}
