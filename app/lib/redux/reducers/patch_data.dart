import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:redux/redux.dart';
import 'package:heroes_companion/redux/actions/actions.dart';
import 'package:flutter/foundation.dart';

final patchesReducer = combineTypedReducers<List<Patch>>([
  new ReducerBinding<List<Patch>, FetchPatchesSucceededAction>(
      _setLoadedBuildInfo),
  new ReducerBinding<List<Patch>, FetchPatchesFailedAction>(_setNoBuildInfo)
]);

List<Patch> _setLoadedBuildInfo(
    List<Patch> patches, FetchPatchesSucceededAction action) {
  return action.patches;
}

List<Patch> _setNoBuildInfo(
    List<Patch> patches, FetchPatchesFailedAction action) {
  return null;
}
