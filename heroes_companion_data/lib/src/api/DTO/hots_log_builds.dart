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
    if (!( map['played'] is String && map['winPercentage'] is String && map['talents'] is List)) {
      throw new Exception('Unexpected JSON format');
    }
    int gamesPlayed = int.parse(map['played']);
    double winPercentage = double.parse(map['winPercentage']);
    List<Map> talentInfo = map['talents'];
    talentInfo.sort((a, b) => a['level'].compareTo(b['level']));
    List<String> talentNames = talentInfo
        .map((talent) => talent['name'])
        .toList();
    return new HotsLogBuild(gamesPlayed, winPercentage, talentNames);
  }
}
