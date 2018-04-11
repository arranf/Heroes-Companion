class UpdateInfo {
  final DateTime id;

  UpdateInfo(this.id);

  factory UpdateInfo.fromJson(Map<dynamic, dynamic> json) {
    if (!(json is Map)) {
      throw new Exception('Update Info: Unexpected JSON format');
    }

    Map<dynamic, dynamic> map = json;
    if (!(map['id'] is String)) {
      throw new Exception('Update Info: Unexpected JSON format');
    }

    DateTime id = DateTime.parse(map['id'] as String);
    return new UpdateInfo(id);
  }
}
