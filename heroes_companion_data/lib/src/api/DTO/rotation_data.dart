class RotationData {
  final DateTime rotationEnd;
  final List<String> heroes;

  RotationData(this.rotationEnd, this.heroes);

  factory RotationData.fromJson(Map<dynamic, dynamic> json) {
    if (!(json is Map)) {
      throw new Exception('Rotation Data: Unexpected JSON format. Not a map.');
    }
    Map<dynamic, dynamic> map = json;
    if (!(map['end'] is String )) {
      throw new Exception('Rotation Data: Unexpected JSON format');
    }
    DateTime rotationEnd = DateTime.parse(map['end'] as String);
    
    List<dynamic> heroInfo = map['heroes'] as List<dynamic>;
    if (!heroInfo.every((m) {
        Map<dynamic, dynamic> map = m as Map<dynamic, dynamic>;
        return map['isFreeToPlay'] is bool;
      })) {
      throw new Exception('Rotation Data: Unexpected JSON format. Not every isFreeToPlay is bool');
    }
    
    List<dynamic> heroNames = heroInfo
        .where((hero) => hero['isFreeToPlay'] as bool)
        .map((hero) => hero['name'])
        .toList();
    return new RotationData(rotationEnd, heroNames.cast<String>());
  }
}
