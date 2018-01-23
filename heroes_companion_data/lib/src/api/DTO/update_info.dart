class UpdateInfo {
  final DateTime id;
  final String sha;

  UpdateInfo(this.id, this.sha);

  factory UpdateInfo.fromJson(Object json) {
    if (!(json is Map)) {
      throw new Exception('Unexpected JSON format');
    }

    Map map = json;
    if (!(map['id'] is String)) {
      throw new Exception('Unexpected JSON format');
    }

    DateTime id = DateTime.parse(map['id']);
    String sha = map['sha'];
    return new UpdateInfo(id, sha);
  }
}
