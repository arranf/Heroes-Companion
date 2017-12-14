import 'package:hots_dog_api/hots_dog_api.dart';
import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';
import 'package:flutter/foundation.dart';

final buildInfoReducer = combineTypedReducers<List<BuildInfo>>([
  new ReducerBinding<List<BuildInfo>, BuildInfoLoadedAction>(_setLoadedBuildInfo),
  new ReducerBinding<List<BuildInfo>, BuildInfoNotLoadedAction>(_setNoBuildInfo)
]);

List<BuildInfo> _setLoadedBuildInfo(List<BuildInfo> hero, BuildInfoLoadedAction action) {
  return action.buildInfo;
}

List<BuildInfo> _setNoBuildInfo(List<BuildInfo> hero, BuildInfoNotLoadedAction action) {
  return null;
}