import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';

final isUpdatingloadingReducer = combineReducers<bool>([
  new TypedReducer<bool, StartUpdatingAction>(_setNotLoaded),
  new TypedReducer<bool, StopUpdatingAction>(_setLoaded),
]);

bool _setLoaded(bool state, action) {
  return false;
}

bool _setNotLoaded(bool state, action) {
  return true;
}
