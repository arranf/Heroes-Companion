class DataSource {
  static const String _hotsDog = 'hots.dog';
  static const String _hotsLogs = 'hotslogs';
  static const HotsDog = const DataSource(_hotsDog);
  static const HotsLogs = const DataSource(_hotsLogs);
  final String name;

  static get values => [HotsDog, HotsLogs,];

  static DataSource fromString(String input) {
    switch(input) {
      case _hotsDog:
        return HotsDog;
      case _hotsLogs:
        return HotsLogs;
      default:
        return HotsDog;
    }
  }

  const DataSource(this.name);
}
