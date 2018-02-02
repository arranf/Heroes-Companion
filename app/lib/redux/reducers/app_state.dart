import 'package:heroes_companion/redux/reducers/is_loading.dart';
import 'package:heroes_companion/redux/reducers/heroes_reducer.dart';
import 'package:heroes_companion/redux/reducers/patch_data.dart';
import 'package:heroes_companion/redux/reducers/win_rates.dart';
import 'package:heroes_companion/redux/reducers/heroes_build_win_rates.dart';
import 'package:heroes_companion/redux/reducers/search_query_reducer.dart';
import 'package:heroes_companion/redux/reducers/is_updating.dart';
import 'package:heroes_companion/redux/reducers/filter_reducer.dart';

import 'package:heroes_companion/redux/reducers/heroes_build_win_rates_loading.dart';
import 'package:heroes_companion/redux/state.dart';

// We create the State reducer by combining many smaller reducers into one!
AppState appReducer(AppState state, action) {
  return new AppState(
      isLoading: loadingReducer(state.isLoading, action),
      heroes: heroesReducer(state.heroes, action),
      patches: patchesReducer(state.patches, action),
      winRates: winRatesReducer(state.winRates, action),
      heroBuildWinRates:
          heroesBuildWinRatesReducer(state.heroBuildWinRates, action),
      heroBuildWinRatesLoading: heroesBuildWinRatesloadingReducer(
          state.heroBuildWinRatesLoading, action),
      searchQuery: searchQueryReducer(state.searchQuery, action),
      isUpdating: isUpdatingloadingReducer(state.isUpdating, action),
      filter: filterReducer(state.filter, action));
}
