class UpdateInfo {
  final DateTime id;

  UpdateInfo(this.id);

  factory UpdateInfo.fromJson(Object json) {
    if (!(json is Map)) {
      throw new Exception('Unexpected JSON format');
    }

    Map map = json;
    if (!(map['id'] is String)) {
      throw new Exception('Unexpected JSON format');
    }

    DateTime id = DateTime.parse(map['id']);
    return new UpdateInfo(id);
  }
}
