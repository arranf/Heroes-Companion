import 'package:hots_dog_api/hots_dog_api.dart';
import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';
import 'package:flutter/foundation.dart';

final buildInfoReducer = combineTypedReducers<List<BuildInfo>>([
  new ReducerBinding<List<BuildInfo>, FetchBuildInfoSucceededAction>(_setLoadedBuildInfo),
  new ReducerBinding<List<BuildInfo>, FetchBuildInfoFailedAction>(_setNoBuildInfo)
]);

List<BuildInfo> _setLoadedBuildInfo(List<BuildInfo> hero, FetchBuildInfoSucceededAction action) {
  return action.buildInfo;
}

List<BuildInfo> _setNoBuildInfo(List<BuildInfo> hero, FetchBuildInfoFailedAction action) {
  return null;
}