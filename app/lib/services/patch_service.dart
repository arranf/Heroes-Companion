import 'package:heroes_companion/redux/actions/actions.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:redux/redux.dart';
import 'package:flutter/foundation.dart';

void getPatches(Store<AppState> store) {
  store.dispatch(new StartLoadingAction());
  // TODO Change interface to actually throw an exception in the case we need special handling
  DataProvider.patchProvider
      .getPatches()
      .then((patches) => store.dispatch(new FetchPatchesSucceededAction(patches)))
      .catchError(
          (Exception e) => store.dispatch(new FetchPatchesFailedAction()));
}

void updatePatches(Store<AppState> store) {
  // TODO Figure out if there needs to be new actions here 
  DataProvider.patchProvider
      .fetchPatches()
      .then((patches) => store.dispatch(new FetchPatchesSucceededAction(patches)))
      .catchError(
          (Exception e) => store.dispatch(new FetchPatchesFailedAction()));
}
