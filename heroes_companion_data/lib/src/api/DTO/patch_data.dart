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
    if (!(json is Map)) {
      throw new Exception('Unexpected JSON format');
    }
    Map map = json;
    String patchName = map['patchName'];
    String officialLink = map['officialLink'];
    String patchType = map['patchType'];
    String gameVersion = map['gameVersion'];
    String fullVersion = map['fullVersion'];
    DateTime liveDate = DateTime.parse(map['liveDate']);
    String patchNotesUrl = map['patchNotesUrl'];

    String alternateLink = '';
    if (map.containsKey('alternateLink')) {
      alternateLink = map['alternateLink'];
    }

    String hotsDogId = '';
    if (map.containsKey('hotsDogId')) {
      hotsDogId = map['hotsDogId'];
    }

    return new PatchData(patchName, officialLink, patchType, gameVersion,
        fullVersion, liveDate, patchNotesUrl,
        hotsDogId: hotsDogId, alternateLink: alternateLink);
  }
}
