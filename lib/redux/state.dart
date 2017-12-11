import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final List<Hero> heroes;
  final bool isLoading;

  AppState({this.isLoading = false, this.heroes});

  factory AppState.loading() => new AppState(isLoading: true);

  AppState copyWith({
    bool isLoading,
    Hero hero
  }) {
    return new AppState(
      isLoading: isLoading ?? this.isLoading,
      heroes: hero ?? this.heroes
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
          heroes == other.heroes;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, heroes: $heroes}';
  }
}

