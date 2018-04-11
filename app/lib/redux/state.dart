import 'package:heroes_companion/models/hero_filter.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final List<Hero> heroes;
  final List<Patch> patches;
  final List<PlayableMap> maps;

  /// BuildNumber => WinRates
  final Map<String, List<HeroWinRate>> winRates;
  final bool isLoading;
  final bool staticialBuildsLoading;
  final bool regularBuildsLoading;
  final bool isUpdating;

  /// heroId => <BuildNumber, StatisticalHeroBuild>
  final Map<int, Map<String, List<StatisticalHeroBuild>>>
      heroStatisticalBuildsByPatchNumber;
  final Map<int, List<Build>> regularHeroBuilds;

  final String searchQuery;
  final HeroFilter filter;

  final Settings settings;

  AppState(
      {this.maps,
      this.isLoading = false,
      this.staticialBuildsLoading = false,
      this.isUpdating = false,
      this.heroes,
      this.patches,
      this.winRates,
      this.heroStatisticalBuildsByPatchNumber,
      this.searchQuery = '',
      this.filter = HeroFilter.all,
      this.settings,
      this.regularHeroBuilds,
      this.regularBuildsLoading});

  factory AppState.initial() => new AppState(
      isLoading: true,
      staticialBuildsLoading: false,
      isUpdating: false,
      regularBuildsLoading: false);

  AppState copyWith({
    bool isLoading,
    List<Hero> heroes,
    List<Patch> patches,
    Map<String, List<HeroWinRate>> winRates,
    bool staticialBuildsLoading,
    bool isUpdating,
    Map<int, Map<String, List<StatisticalHeroBuild>>> statisticalBuilds,
    String searchQuery,
    HeroFilter filter,
    List<PlayableMap> maps,
    Settings settings,
    Map<int, List<Build>> regularHeroBuilds,
    bool regularBuildsLoading,
  }) {
    return new AppState(
      isLoading: isLoading ?? this.isLoading,
      heroes: heroes ?? this.heroes,
      patches: patches ?? this.patches,
      winRates: winRates ?? this.winRates,
      isUpdating: isUpdating ?? this.isUpdating,
      staticialBuildsLoading:
          staticialBuildsLoading ?? this.staticialBuildsLoading,
      heroStatisticalBuildsByPatchNumber:
          statisticalBuilds ?? this.heroStatisticalBuildsByPatchNumber,
      searchQuery: searchQuery ?? this.searchQuery,
      filter: filter ?? this.filter,
      maps: maps ?? this.filter,
      settings: settings ?? this.settings,
      regularBuildsLoading: regularBuildsLoading ?? this.regularBuildsLoading,
      regularHeroBuilds: regularHeroBuilds ?? this.regularHeroBuilds,
    );
  }

  // TODO USE COLLECTION EQUALITY SEE hots_dog_api
  @override
  int get hashCode =>
      isLoading.hashCode ^
      heroes.hashCode ^
      patches.hashCode ^
      winRates.hashCode ^
      staticialBuildsLoading.hashCode ^
      heroStatisticalBuildsByPatchNumber.hashCode ^
      searchQuery.hashCode ^
      isUpdating.hashCode ^
      filter.hashCode ^
      maps.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          // TODO USE COLLECTION EQUALITY SEE hots_dog_api
          heroes == other.heroes &&

          // TODO USE COLLECTION EQUALITY SEE hots_dog_api
          patches == other.patches &&

          // TODO USE COLLECTION EQUALITY SEE hots_dog_api
          winRates == other.winRates &&
          staticialBuildsLoading == other.staticialBuildsLoading &&

          // TODO USE COLLECTION EQUALITY SEE hots_dog_api
          heroStatisticalBuildsByPatchNumber ==
              other.heroStatisticalBuildsByPatchNumber &&
          searchQuery == other.searchQuery &&
          isUpdating == other.isUpdating &&
          filter == other.filter;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading}';
  }
}
