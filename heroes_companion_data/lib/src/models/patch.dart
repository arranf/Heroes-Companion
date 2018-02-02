import 'package:heroes_companion_data/src/api/DTO/patch_data.dart';
import 'package:heroes_companion_data/src/tables/patch_table.dart' as table;

class Patch {
  final int id;
  final String patchName;
  final String officialLink;
  final String alternateLink;
  final String patchType;
  final String gameVersion;
  final String fullVersion;
  final DateTime liveDate;
  final String patchNotesUrl;

  Patch(this.patchName, this.officialLink, this.alternateLink, this.patchType,
      this.gameVersion, this.fullVersion, this.liveDate, this.patchNotesUrl,
      {this.id});

  factory Patch.from(PatchData patchData) {
    return new Patch(
        patchData.patchName,
        patchData.officialLink,
        patchData.alternateLink,
        patchData.patchType,
        patchData.gameVersion,
        patchData.fullVersion,
        patchData.liveDate,
        patchData.patchNotesUrl);
  }

  factory Patch.fromMap(Map map) {
    int id = map[table.column_id];
    String patchName = map[table.column_patch_name];
    String officialLink = map[table.column_official_link];
    String alternateLink = map[table.column_alternate_link];
    String patchType = map[table.column_patch_type];
    String gameVersion = map[table.column_game_version];
    String fullVersion = map[table.column_full_version];
    DateTime liveDate = DateTime.parse(map[table.column_live_date]);
    String patchNotesUrl = map[table.column_patch_notes_url];

    return new Patch(patchName, officialLink, alternateLink, patchType,
        gameVersion, fullVersion, liveDate, patchNotesUrl,
        id: id);
  }

  Map toMap() {
    Map map = {
      table.column_id: id,
      table.column_patch_name: patchName,
      table.column_official_link: officialLink,
      table.column_alternate_link: alternateLink,
      table.column_patch_type: patchType,
      table.column_game_version: gameVersion,
      table.column_full_version: fullVersion,
      table.column_live_date: liveDate.toIso8601String(),
      table.column_patch_notes_url: patchNotesUrl,
    };
    return map;
  }
}
