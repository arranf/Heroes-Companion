import 'package:heroes_companion/models/hero_filter.dart';
import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';
import 'package:flutter/foundation.dart';

final filterReducer = combineTypedReducers<HeroFilter>([
  new ReducerBinding<HeroFilter, SetFilterAction>(
      _setFilter)
]);

HeroFilter _setFilter(HeroFilter filter, SetFilterAction action) {
  return action.filter;
}