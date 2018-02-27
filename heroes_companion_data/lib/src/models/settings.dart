import 'package:heroes_companion_data/src/models/data_source.dart';
import 'package:heroes_companion_data/src/models/theme_type.dart';

class Settings {
  final DateTime currentUpdateOriginTime;
  final DateTime nextRotationDate;
  final String updatePatch;
  final DataSource dataSource;
  final ThemeType themeType;

  Settings(this.currentUpdateOriginTime, this.nextRotationDate,
      this.updatePatch, this.dataSource, this.themeType);

  Settings copyWith(
      {DateTime currentUpdateOriginTime,
      DateTime nextRotationDate,
      String updatePatch,
      DataSource dataSource,
      ThemeType themeType}) {
    return new Settings(
      currentUpdateOriginTime ?? this.currentUpdateOriginTime,
      nextRotationDate ?? this.nextRotationDate,
      updatePatch ?? this.updatePatch,
      dataSource ?? this.dataSource,
      themeType ?? this.themeType,
    );
  }
}
