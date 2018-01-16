class HeroesCompanionData {
  final DateTime rotationEnd;
  final List<String> heroes;

  HeroesCompanionData(this.rotationEnd, this.heroes);

  factory HeroesCompanionData.fromJson(Object json) {
    if (!(json is Map)) {
      throw new Exception('Unexpected JSON format');
    }
    Map map = json;
    if (!(map['end'] is String && map['heroes'] is List<Map>)) {
      throw new Exception('Unexpected JSON format');
    }
    DateTime rotationEnd = DateTime.parse(map['end']);
    List<Map> heroInfo = map['heroes'];
    List<String> heroes = heroInfo
        .where((hero) => hero['isFreeToPlay'])
        .map((hero) => hero['name'])
        .toList();
    return new HeroesCompanionData(rotationEnd, heroes);
  }
}
