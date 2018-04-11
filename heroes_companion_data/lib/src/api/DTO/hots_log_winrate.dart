class HotsLogsWinrate {
  final String name;
  final int gamesPlayed;
  final double winPercentage;

  HotsLogsWinrate(this.name, this.gamesPlayed, this.winPercentage);

  factory HotsLogsWinrate.fromJson(Map<dynamic, dynamic> json) {
    if (!(json is Map)) {
      throw new Exception('HotsLogWinrate: Unexpected JSON format');
    }
    Map<dynamic, dynamic> map = json;
    if (!(map['name'] is String &&
        map['played'] is String &&
        map['winPercentage'] is String)) {
      throw new Exception('HotsLogWinrate: Unexpected JSON format');
    }
    String name = map['name'];
    int gamesPlayed = int.parse(map['played'] as String);
    double winPercentage = double.parse(map['winPercentage'] as String);
    return new HotsLogsWinrate(name, gamesPlayed, winPercentage);
  }
}
