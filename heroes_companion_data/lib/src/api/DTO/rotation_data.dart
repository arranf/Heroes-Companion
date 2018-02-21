class RotationData {
  final DateTime rotationEnd;
  final List<String> heroes;

  RotationData(this.rotationEnd, this.heroes);

  factory RotationData.fromJson(Object json) {
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
    return new RotationData(rotationEnd, heroes);
  }
}
