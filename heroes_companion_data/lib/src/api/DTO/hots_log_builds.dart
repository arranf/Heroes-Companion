class HotsLogBuild {
  final int gamesPlayed;
  final double winPercentage;
  final List<String> talentNames;

  HotsLogBuild(this.gamesPlayed, this.winPercentage, this.talentNames);

  factory HotsLogBuild.fromJson(Map<dynamic, dynamic> json) {
    if (!(json is Map)) {
      throw new Exception('Hots_Log_Build: Unexpected JSON format');
    }
    Map<dynamic, dynamic> map = json;
    if (!(map['gamesPlayed'] is String &&
        map['winPercentage'] is String &&
        map['talents'] is List)) {
      throw new Exception('Hots_Log_Build: Unexpected JSON format');
    }
    int gamesPlayed = int.parse(map['gamesPlayed'] as String);
    double winPercentage = double.parse(map['winPercentage'] as String);

    List<Map<dynamic, dynamic>> talentInfo =
        (map['talents'] as List<dynamic>).cast<Map<dynamic, dynamic>>();
    talentInfo.sort((a, b) {
      int aVal = a['level'];
      int bVal = b['level'];
      return aVal.compareTo(bVal);
    });
    List<String> talentNames =
        (talentInfo.map((talent) => talent['name']).toList()).cast<String>();
    return new HotsLogBuild(gamesPlayed, winPercentage, talentNames);
  }
}
