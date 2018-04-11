import 'package:meta/meta.dart';

/// TODO refactor this to use [HeroBuild] when it has changed to use [Talent] rather than a list of talent names
class Build {
  final List<String> talentTreeIds;
  final DateTime submitted;
  final int heroId;
  final String tagline;
  final String id;

  // Not always present
  final String description;
  final String source;
  final String url;

  Build(
      {@required this.talentTreeIds,
      @required this.submitted,
      @required this.heroId,
      this.tagline,
      @required this.id,
      this.description,
      this.source,
      this.url});

  factory Build.fromJson(Map<dynamic, dynamic> json) {
    if (!(json is Map)) {
      throw new Exception('Build: Unexpected JSON format making bui');
    }
    Map<dynamic, dynamic> map = json;
    if (!(map['Submitted'] is String &&
        map['_id'] is String &&
        map['Talents'] is List &&
        map['HeroId'] is int)) {
      throw new Exception('Build: Unexpected JSON format');
    }

    DateTime submitted = DateTime.parse(map['Submitted'] as String);
    int heroId = map['HeroId'];
    String id = map['_id'];

    String description;
    if (map.containsKey('Description') && map['Description'] is String) {
      description = map['Description'] as String;
    }

    String source;
    if (map.containsKey('Source') && map['Source'] is String) {
      source = map['Source'] as String;
    }

    String url;
    if (map.containsKey('Url') && map['Url'] is String) {
      url = map['Url'] as String;
    }

    String tagline;
    if (map.containsKey('Tagline') && map['Tagline'] is String) {
      tagline = map['Tagline'] as String;
    }

    List<Map<dynamic, dynamic>> talentInfo = map['Talents'];
    talentInfo.sort((Map<dynamic, dynamic> a, Map<dynamic, dynamic> b) {
      int aVal = a['Level'];
      int bVal = b['Level'];
      return aVal.compareTo(bVal);
    });
    List<String> talentTreeIds =
        talentInfo.map((talent) => talent['TalentTreeId']).toList();
    return new Build(
        talentTreeIds: talentTreeIds,
        submitted: submitted,
        heroId: heroId,
        id: id,
        description: description,
        source: source,
        url: url,
        tagline: tagline);
  }
}
