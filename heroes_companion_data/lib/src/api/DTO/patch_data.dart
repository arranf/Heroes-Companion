class PatchData {
  final String patchName;
  final String officialLink;
  final String alternateLink;
  final String patchType;
  final String gameVersion;
  final String fullVersion;
  final DateTime liveDate;
  final String patchNotesUrl;
  final String hotsDogId;

  PatchData(this.patchName, this.officialLink, this.patchType, this.gameVersion,
      this.fullVersion, this.liveDate, this.patchNotesUrl,
      {this.alternateLink, this.hotsDogId});

  factory PatchData.fromJson(Object json) {
    if (!(json is Map && json['liveDate'] is String)) {
      throw new Exception('Unexpected JSON format');
    }
    Map map = json;
    String patchName = map['patchName'];
    String officialLink = map['officialLink'];
    String patchType = map['patchType'];
    String gameVersion = map['gameVersion'];
    String fullVersion = map['fullVersion'];
    DateTime liveDate = DateTime.parse(map['liveDate'] as String);
    String patchNotesUrl = map['patchNotesUrl'];

    String alternateLink = '';
    if (map.containsKey('alternateLink') && map['alternateLink'] is String) {
      alternateLink = map['alternateLink'] as String;
    }

    String hotsDogId = '';
    if (map.containsKey('hotsDogId') && map['hotsDogId'] is String) {
      hotsDogId = map['hotsDogId'] as String;
    }

    return new PatchData(patchName, officialLink, patchType, gameVersion,
        fullVersion, liveDate, patchNotesUrl,
        hotsDogId: hotsDogId, alternateLink: alternateLink);
  }
}
