import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';

final searchQueryReducer = combineReducers<String>([
  new TypedReducer<String, SetSearchQueryAction>(_setQuery),
  new TypedReducer<String, ClearSearchQueryAction>(_clearQuery)
]);

String _setQuery(String query, SetSearchQueryAction action) {
  return action.searchQuery;
}

String _clearQuery(String query, ClearSearchQueryAction action) {
  return '';
}
