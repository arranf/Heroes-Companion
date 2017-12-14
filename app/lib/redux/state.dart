import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:meta/meta.dart';
import 'package:hots_dog_api/hots_dog_api.dart';

@immutable
class AppState {
  final List<Hero> heroes;
  final List<BuildInfo> buildInfo;
  final WinRates winRates;
  final bool isLoading;

  AppState({this.isLoading = false, this.heroes, this.buildInfo, this.winRates,});

  factory AppState.loading() => new AppState(isLoading: true);

  AppState copyWith({
    bool isLoading,
    Hero hero,
    List<BuildInfo> buildInfo,
    WinRates winRates,
  }) {
    return new AppState(
      isLoading: isLoading ?? this.isLoading,
      heroes: hero ?? this.heroes,
      buildInfo: buildInfo ?? this.buildInfo,
      winRates: winRates ?? this.winRates,
    );
  }

  @override
  int get hashCode =>
      isLoading.hashCode ^
      heroes.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          heroes == other.heroes &&
          buildInfo == other.buildInfo &&
          winRates == other.winRates;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, heroes: $heroes, buildInfo: $buildInfo, winRates: $winRates}';
  }
}

