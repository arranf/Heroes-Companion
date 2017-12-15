import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:meta/meta.dart';
import 'package:hots_dog_api/hots_dog_api.dart';

@immutable
class AppState {
  final List<Hero> heroes;
  final List<BuildInfo> gameBuilds;
  final WinRates winRates;
  final bool isLoading;
  final bool heroBuildWinRatesLoading;
  final Map<int, BuildWinRates> heroBuildWinRates;

  AppState({this.isLoading = false, this.heroBuildWinRatesLoading = false, this.heroes, this.gameBuilds, this.winRates, this.heroBuildWinRates,});

  factory AppState.loading() => new AppState(isLoading: true, heroBuildWinRatesLoading: false);

  AppState copyWith({
    bool isLoading,
    Hero hero,
    List<BuildInfo> buildInfo,
    WinRates winRates,
    bool heroBuildWinRatesLoading,
    Map<int, BuildWinRates> heroBuildWinRates,
  }) {
    return new AppState(
      isLoading: isLoading ?? this.isLoading,
      heroes: hero ?? this.heroes,
      gameBuilds: buildInfo ?? this.gameBuilds,
      winRates: winRates ?? this.winRates,
      heroBuildWinRatesLoading: heroBuildWinRatesLoading ?? this.heroBuildWinRatesLoading,
      heroBuildWinRates: heroBuildWinRates ?? this.heroBuildWinRates,
    );
  }

  @override
  int get hashCode =>
      isLoading.hashCode ^
      heroes.hashCode ^
      gameBuilds.hashCode ^
      winRates.hashCode ^
      heroBuildWinRatesLoading.hashCode ^
      heroBuildWinRates.hashCode;

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
          heroBuildWinRates == other.heroBuildWinRates;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, heroes: $heroes, buildInfo: $gameBuilds, winRates: $winRates}';
  }
}

