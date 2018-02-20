class Settings {
  final DateTime currentUpdateOriginTime;
  final DateTime nextRotationDate;
  final String updatePatch;

  Settings(this.currentUpdateOriginTime, this.nextRotationDate, this.updatePatch);

  Settings copyWith({DateTime currentUpdateOriginTime, DateTime nextRotationDate, String updatePatch}) {
    return new Settings(currentUpdateOriginTime ?? this.currentUpdateOriginTime, 
    nextRotationDate ?? this.nextRotationDate, 
    updatePatch ?? this.updatePatch);
  }
}