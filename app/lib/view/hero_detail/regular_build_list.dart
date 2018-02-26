import 'package:flutter/material.dart' hide Hero;
import 'package:heroes_companion/models/build_sort.dart';
import 'package:heroes_companion/view/common/regular_build_card.dart';
import 'package:heroes_companion/view/common/empty_state.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';

class RegularBuildList extends StatelessWidget {
  final Hero hero;
  final dynamic playBuild;
  final dynamic showTalentBottomSheet;
  final List<Build> builds;

  RegularBuildList(this.hero, this.playBuild, this.showTalentBottomSheet, this.builds,);
  

  @override
  Widget build(BuildContext context) {
    if (builds != null && builds.isNotEmpty) {
      return new ListView(
        key: new Key(hero.name + '_talent_rows'),
        children: builds.map((Build b) => new RegularBuildCard(b,  playBuild, hero, showTalentBottomSheet)).toList()
      );
    }
    return new EmptyState(Icons.error_outline, title: 'No Data Available', description: 'No statistical data found for this hero');
  }
}