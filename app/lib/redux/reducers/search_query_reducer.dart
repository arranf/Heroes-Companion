import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';

final searchQueryReducer = combineTypedReducers<String>([
  new ReducerBinding<String, SetSearchQueryAction>(_setQuery),
  new ReducerBinding<String, ClearSearchQueryAction>(_clearQuery)
]);

String _setQuery(String query, SetSearchQueryAction action) {
  return action.searchQuery;
}

String _clearQuery(String query, ClearSearchQueryAction action) {
  return '';
}
