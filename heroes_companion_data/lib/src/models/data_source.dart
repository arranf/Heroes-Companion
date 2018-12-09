class DataSource {
  static const String _hotsDog = 'hots.dog';
  static const String _hotsLogs = 'hotslogs.com';
  static const HotsDog = const DataSource(_hotsDog);
  static const HotsLogs = const DataSource(_hotsLogs);
  final String name;

  static get values => [
    HotsDog,
    HotsLogs,
  ];

  static DataSource fromString(String input) {
    switch (input) {
      case _hotsDog:
        return HotsDog;
      case _hotsLogs:
        return HotsLogs;
      default:
        return HotsLogs;
    }
  }

  const DataSource(this.name);
}
