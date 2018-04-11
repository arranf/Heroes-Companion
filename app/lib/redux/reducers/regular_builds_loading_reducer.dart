import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';

final regularBuildsLoadingReducer = combineReducers<bool>([
  new TypedReducer<bool, FetchHeroBuildsStartLoadingAction>(_setNotLoaded),
  new TypedReducer<bool, FetchHeroBuildsFailedAction>(_setLoaded),
  new TypedReducer<bool, FetchHeroBuildsSucceededAction>(_setLoaded),
]);

bool _setLoaded(bool state, action) {
  return false;
}

bool _setNotLoaded(bool state, action) {
  return true;
}
