import 'package:flutter/material.dart' hide Hero;
import 'package:heroes_companion/models/build_sort.dart';
import 'package:heroes_companion/view/common/statistical_build_card.dart';
import 'package:heroes_companion/view/common/empty_state.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';

class StatisticalBuildList extends StatelessWidget {
  final Hero hero;
  final dynamic playBuild;
  final dynamic showTalentBottomSheet;
  final List<StatisticalHeroBuild> statisticalBuilds;
  final BuildSort buildSort;

  StatisticalBuildList(this.hero, this.playBuild, this.showTalentBottomSheet,
      this.statisticalBuilds, this.buildSort);

  @override
  Widget build(BuildContext context) {
    if (statisticalBuilds != null && statisticalBuilds.isNotEmpty) {
      // Prevent duplicates (builds in popular *and* winning)
      List<StatisticalHeroBuild> builds = statisticalBuilds
          .where((StatisticalHeroBuild b) =>
              b.build.talentNames.length == 7 && b.winRate > 0.0)
          .toSet()
          .toList();
      // Sort builds by games played
      if (buildSort == BuildSort.playrate) {
        builds.sort((StatisticalHeroBuild a, StatisticalHeroBuild b) =>
            -1 * a.gamesPlayed.compareTo(b.gamesPlayed));
      } else {
        builds.sort((StatisticalHeroBuild a, StatisticalHeroBuild b) =>
            -1 * a.winRate.compareTo(b.winRate));
      }

      return new ListView(
          key: new Key(hero.name + '_talent_rows'),
          children: builds
              .map((StatisticalHeroBuild b) => new BuildCard(
                    b,
                    playBuild,
                    hero,
                    showTalentBottomSheet,
                    type: b.label,
                  ))
              .toList());
    }
    return new EmptyState(Icons.error_outline,
        title: 'No Data Available',
        description: 'No statistical data found for this hero');
  }
}
