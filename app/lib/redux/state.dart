import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:meta/meta.dart';
import 'package:hots_dog_api/hots_dog_api.dart';

@immutable
class AppState {
  final List<Hero> heroes;
  final List<BuildInfo> gameBuilds;
  /// BuildNumber => WinRates
  final Map<String, WinRates> winRates;
  final bool isLoading;
  final bool heroBuildWinRatesLoading;
  /// heroCompanionId => <BuildNumber, BuildWinRates>
  final Map<int, Map<String, BuildWinRates>> heroBuildWinRates;
  final String searchQuery;

  AppState({
    this.isLoading = false,
    this.heroBuildWinRatesLoading = false,
    this.heroes,
    this.gameBuilds,
    this.winRates,
    this.heroBuildWinRates,
    this.searchQuery = '',
  });

  factory AppState.loading() =>
      new AppState(isLoading: true, heroBuildWinRatesLoading: false);

  AppState copyWith({
    bool isLoading,
    Hero hero,
    List<BuildInfo> buildInfo,
    Map<String, WinRates> winRates,
    bool heroBuildWinRatesLoading,
    Map<int, Map<String, BuildWinRates>> heroBuildWinRates,
    String searchQuery
  }) {
    return new AppState(
      isLoading: isLoading ?? this.isLoading,
      heroes: hero ?? this.heroes,
      gameBuilds: buildInfo ?? this.gameBuilds,
      winRates: winRates ?? this.winRates,
      heroBuildWinRatesLoading: heroBuildWinRatesLoading ?? this.heroBuildWinRatesLoading,
      heroBuildWinRates: heroBuildWinRates ?? this.heroBuildWinRates,
      searchQuery: searchQuery ?? this.searchQuery
    );
  }

  @override
  int get hashCode =>
      isLoading.hashCode ^
      heroes.hashCode ^
      gameBuilds.hashCode ^
      winRates.hashCode ^
      heroBuildWinRatesLoading.hashCode ^
      heroBuildWinRates.hashCode ^
      searchQuery.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          heroes == other.heroes &&
          gameBuilds == other.gameBuilds &&
          winRates == other.winRates &&
          heroBuildWinRatesLoading == other.heroBuildWinRatesLoading &&
          heroBuildWinRates == other.heroBuildWinRates &&
          searchQuery == other.searchQuery;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, heroes: $heroes, buildInfo: $gameBuilds, winRates: $winRates}';
  }
}
