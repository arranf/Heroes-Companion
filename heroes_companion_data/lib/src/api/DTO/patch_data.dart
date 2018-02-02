class PatchData {
  final String patchName;
  final String officialLink;
  String alternateLink = '';
  final String patchType;
  final String gameVersion;
  final String fullVersion;
  final DateTime liveDate;
  final String patchNotesUrl;

  PatchData(this.patchName, this.officialLink, this.patchType, this.gameVersion, this.fullVersion, this.liveDate, this.patchNotesUrl, {this.alternateLink});

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
    if (map.containsKey('alternateLink')){
      return new PatchData(patchName, officialLink, patchType, gameVersion, fullVersion, liveDate, patchNotesUrl, alternateLink: map['alternateLink']);
    }
    return new PatchData(patchName, officialLink, patchType, gameVersion, fullVersion, liveDate, patchNotesUrl);
  }
}