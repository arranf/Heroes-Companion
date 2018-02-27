import 'package:heroes_companion/redux/reducers/is_loading.dart';
import 'package:heroes_companion/redux/reducers/heroes_reducer.dart';
import 'package:heroes_companion/redux/reducers/patch_data.dart';
import 'package:heroes_companion/redux/reducers/win_rates.dart';
import 'package:heroes_companion/redux/reducers/heroes_build_win_rates.dart';
import 'package:heroes_companion/redux/reducers/search_query_reducer.dart';
import 'package:heroes_companion/redux/reducers/is_updating.dart';
import 'package:heroes_companion/redux/reducers/filter_reducer.dart';
import 'package:heroes_companion/redux/reducers/maps_reducer.dart';
import 'package:heroes_companion/redux/reducers/settings_reducer.dart';
import 'package:heroes_companion/redux/reducers/regular_build_reducer.dart';
import 'package:heroes_companion/redux/reducers/regular_builds_loading_reducer.dart';
import 'package:heroes_companion/redux/reducers/heroes_build_win_rates_loading.dart';
import 'package:heroes_companion/redux/state.dart';

// We create the State reducer by combining many smaller reducers into one!
AppState appReducer(AppState state, action) {
  return new AppState(
    isLoading: loadingReducer(state.isLoading, action),
    heroes: heroesReducer(state.heroes, action),
    patches: patchesReducer(state.patches, action),
    winRates: winRatesReducer(state.winRates, action),
    heroStatisticalBuildsByPatchNumber: heroesStatisticalBuildsReducer(
        state.heroStatisticalBuildsByPatchNumber, action),
    staticialBuildsLoading: heroStatisticialBuildsLoadingReducer(
        state.staticialBuildsLoading, action),
    searchQuery: searchQueryReducer(state.searchQuery, action),
    isUpdating: isUpdatingloadingReducer(state.isUpdating, action),
    filter: filterReducer(state.filter, action),
    maps: mapsReducer(state.maps, action),
    settings: settingsReducer(state.settings, action),
    regularBuildsLoading:
        regularBuildsLoadingReducer(state.regularBuildsLoading, action),
    regularHeroBuilds:
        regularHeroBuildsReducer(state.regularHeroBuilds, action),
  );
}
