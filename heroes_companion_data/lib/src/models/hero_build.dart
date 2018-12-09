import 'package:collection/collection.dart';

class HeroBuild {
  final int heroId;
  final List<String> talentNames;

  // TODO Refactor this to be a list of talents
  HeroBuild(this.heroId, this.talentNames);

  @override
  int get hashCode {
    var hash = const ListEquality().hash;
    return this.heroId.hashCode ^ hash(talentNames);
  }

  @override
  bool operator == (Object other) 
  {
      var equals = const ListEquality().equals;
      return identical(this, other) ||
      other is HeroBuild &&
          this.heroId == other.heroId &&
          equals(this.talentNames, other.talentNames);
  }
}
