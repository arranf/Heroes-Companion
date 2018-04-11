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
    
    List<Map<String, dynamic>> heroInfo = map['heroes'];
    if (!heroInfo.every((m) => m['isFreeToPlay'] is bool)) {
      throw new Exception('Rotation Data: Unexpected JSON format. Not every isFreeToPlay is bool');
    }
    
    List<String> heroNames = heroInfo
        .where((hero) => hero['isFreeToPlay'] as bool)
        .map((hero) => hero['name'])
        .toList();
    return new RotationData(rotationEnd, heroNames);
  }
}
