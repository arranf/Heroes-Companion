import 'package:heroes_companion/models/hero_filter.dart';
import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';

final filterReducer = combineReducers<HeroFilter>(
    [new TypedReducer<HeroFilter, SetFilterAction>(_setFilter)]);

HeroFilter _setFilter(HeroFilter filter, SetFilterAction action) {
  return action.filter;
}
