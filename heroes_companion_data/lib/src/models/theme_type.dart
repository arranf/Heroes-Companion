class ThemeType {
  static const String _light = 'Light';
  static const String _dark = 'Dark';
  static const Light = const ThemeType(_light);
  static const Dark = const ThemeType(_dark);
  final String name;

  static get values => [
        Light,
        Dark,
      ];

  static ThemeType fromString(String input) {
    switch (input) {
      case _light:
        return Light;
      case _dark:
        return Dark;
      default:
        return Light;
    }
  }

  const ThemeType(this.name);
}
