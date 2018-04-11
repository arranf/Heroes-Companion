class HotsLogBuild {
  final int gamesPlayed;
  final double winPercentage;
  final List<String> talentNames;

  HotsLogBuild(this.gamesPlayed, this.winPercentage, this.talentNames);

  factory HotsLogBuild.fromJson(Object json) {
    if (!(json is Map)) {
      throw new Exception('Unexpected JSON format');
    }
    Map map = json;
    if (!(map['gamesPlayed'] is String &&
        map['winPercentage'] is String &&
        map['talents'] is List)) {
      throw new Exception('Unexpected JSON format');
    }
    int gamesPlayed = int.parse(map['gamesPlayed'] as String);
    double winPercentage = double.parse(map['winPercentage'] as String);
    List<Map> talentInfo = map['talents'];
    talentInfo.sort((a, b) {
      int aVal = a['level'];
      int bVal = b['level'];
      aVal.compareTo(bVal);
    });
    List<String> talentNames =
        talentInfo.map((talent) => talent['name']).toList();
    return new HotsLogBuild(gamesPlayed, winPercentage, talentNames);
  }
}
