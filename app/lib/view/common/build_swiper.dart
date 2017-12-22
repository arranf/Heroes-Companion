import 'package:flutter/material.dart' hide Hero;
import 'package:heroes_companion/view/common/talent_card.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:hots_dog_api/hots_dog_api.dart' hide Talent;

class BuildSwiper extends StatefulWidget {
  final Hero hero;
  final BuildStatistics buildWinRates;

  BuildSwiper(
    this.hero,
    this.buildWinRates,
    {
    key,
    }
  )
      : super(key: key);

    
  @override
  State createState() => new _BuildSwiperState();

}

class _BuildSwiperState extends State<BuildSwiper> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        new TabController(vsync: this, length: widget.buildWinRates.talents_names.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Theme.of(context).primaryColor,
      child: new TabBarView(
        controller: _tabController,
        children: widget.buildWinRates.talents_names.map( (String talentName) {
          return new TalentCard(widget.hero.talents.firstWhere((Talent t) => t.talent_tree_id == talentName));
        }).toList(),
      ),
    );
  }
}