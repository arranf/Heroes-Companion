import 'package:heroes_companion/models/hero_filter.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:meta/meta.dart';
import 'package:hots_dog_api/hots_dog_api.dart';

@immutable
class AppState {
  final List<Hero> heroes;
  final List<Patch> patches;
  final List<PlayableMap> maps;

  /// BuildNumber => WinRates
  final Map<String, List<HeroWinRate>> winRates;
  final bool isLoading;
  final bool heroBuildWinRatesLoading;
  final bool isUpdating;

  /// heroId => <BuildNumber, BuildWinRates>
  final Map<int, Map<String, BuildWinRates>> heroBuildWinRates;
  final String searchQuery;
  final HeroFilter filter;

  AppState({
    this.maps,
    this.isLoading = false,
    this.heroBuildWinRatesLoading = false,
    this.isUpdating = false,
    this.heroes,
    this.patches,
    this.winRates,
    this.heroBuildWinRates,
    this.searchQuery = '',
    this.filter = HeroFilter.all
  });

  factory AppState.initial() => new AppState(
      isLoading: true, heroBuildWinRatesLoading: false, isUpdating: false);

  AppState copyWith({
    bool isLoading,
    List<Hero> heroes,
    List<Patch> patches,
    Map<String, List<HeroWinRate>> winRates,
    bool heroBuildWinRatesLoading,
    bool isUpdating,
    Map<int, Map<String, BuildWinRates>> heroBuildWinRates,
    String searchQuery,
    HeroFilter filter,
    List<PlayableMap> maps,
  }) {
    return new AppState(
      isLoading: isLoading ?? this.isLoading,
      heroes: heroes ?? this.heroes,
      patches: patches ?? this.patches,
      winRates: winRates ?? this.winRates,
      isUpdating: isUpdating ?? this.isUpdating,
      heroBuildWinRatesLoading: heroBuildWinRatesLoading ?? this.heroBuildWinRatesLoading,
      heroBuildWinRates: heroBuildWinRates ?? this.heroBuildWinRates,
      searchQuery: searchQuery ?? this.searchQuery,
      filter: filter ?? this.filter,
      maps: maps ?? this.filter,
    );
  }


  // TODO USE COLLECTION EQUALITY SEE hots_dog_api
  @override
  int get hashCode =>
      isLoading.hashCode ^
      heroes.hashCode ^
      patches.hashCode ^
      winRates.hashCode ^
      heroBuildWinRatesLoading.hashCode ^
      heroBuildWinRates.hashCode ^
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
          heroBuildWinRatesLoading == other.heroBuildWinRatesLoading &&

          // TODO USE COLLECTION EQUALITY SEE hots_dog_api
          heroBuildWinRates == other.heroBuildWinRates &&
          searchQuery == other.searchQuery &&
          isUpdating == other.isUpdating &&
          filter == other.filter;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading}';
  }
}
