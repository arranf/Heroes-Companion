import 'package:heroes_companion_data/src/api/DTO/patch_data.dart';

class Patch {
  final String patchName;
  final String officialLink;
  String alternateLink;
  final String patchType;
  final String gameVersion;
  final String fullVersion;
  final DateTime liveDate;
  final String patchNotesUrl;

  Patch(this.patchName, this.officialLink, this.alternateLink, this.patchType, this.gameVersion, this.fullVersion, this.liveDate, this.patchNotesUrl);

  factory Patch.from(PatchData patchData) {
    return new Patch(patchData.patchName, patchData.officialLink, patchData.alternateLink, patchData.patchType, patchData.gameVersion, patchData.fullVersion, patchData.liveDate, patchData.patchNotesUrl)
  }
}