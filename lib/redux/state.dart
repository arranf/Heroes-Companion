import 'package:meta/meta.dart';
import 'package:hots_dog_api/hots_dog_api.dart';

@immutable
class AppState {
  final GameInfo gameInfo;
  final bool isLoading;

  AppState({this.isLoading = false, this.gameInfo});

  factory AppState.loading() => new AppState(isLoading: true);

  AppState copyWith({
    bool isLoading,
    GameInfo gameInfo
  }) {
    return new AppState(
      isLoading: isLoading ?? this.isLoading,
      gameInfo: gameInfo ?? this.gameInfo
    );
  }

  @override
  int get hashCode =>
      isLoading.hashCode ^
      gameInfo.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          gameInfo == other.gameInfo;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, GameInfo: $gameInfo}';
  }
}

