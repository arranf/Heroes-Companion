import 'package:heroes_companion_data/src/models/data_source.dart';

class Settings {
  final DateTime currentUpdateOriginTime;
  final DateTime nextRotationDate;
  final String updatePatch;
  final DataSource dataSource;

  Settings(this.currentUpdateOriginTime, this.nextRotationDate, this.updatePatch, this.dataSource);

  Settings copyWith({DateTime currentUpdateOriginTime, DateTime nextRotationDate, String updatePatch}) {
    return new Settings(currentUpdateOriginTime ?? this.currentUpdateOriginTime, 
    nextRotationDate ?? this.nextRotationDate, 
    updatePatch ?? this.updatePatch,
    dataSource ?? this.dataSource,
    );
  }
}