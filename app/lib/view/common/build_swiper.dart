import 'package:heroes_companion/i18n/strings.dart';
// import 'package:screen/screen.dart';
import 'package:flutter/material.dart' hide Hero;
import 'package:heroes_companion/view/common/talent_card.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';

class BuildSwiper extends StatefulWidget {
  final Hero hero;
  final HeroBuild build;

  BuildSwiper(
    this.hero,
    this.build, {
    key,
  }) : super(key: key);

  @override
  State createState() => new _BuildSwiperState();
}

class _BuildSwiperState extends State<BuildSwiper>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Screen.keepOn(true);
    _tabController =
        new TabController(vsync: this, length: widget.build.talentNames.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    // Screen.keepOn(false);
    super.dispose();
  }

  void _nextPage(int delta) {
    final int newIndex = _tabController.index + delta;
    if (newIndex < 0 || newIndex >= _tabController.length) return;
    _tabController.animateTo(newIndex);
  }

  void _firstPage() {
    _tabController.animateTo(0);
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return new Card(
        key: new Key('${widget.hero.name}_swiper'),
        color: Theme.of(context).primaryColor,
        child: new Column(
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.only(top: statusBarHeight),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new IconButton(
                    icon: new Icon(Icons.close),
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                    tooltip: AppStrings.of(context).goBack(),
                  ),
                  new IconButton(
                    icon: new Icon(Icons.first_page),
                    color: Colors.white,
                    onPressed: () => _firstPage(),
                    tooltip: AppStrings.of(context).goToFirstTalent(),
                  )
                ],
              ),
            ),
            new Flexible(
              child: new TabBarView(
                key: new Key('${widget.hero.name}_swiper_tab_bar_view'),
                controller: _tabController,
                children: widget.build.talentNames.map((String talentName) {
                  Talent talent = widget.hero.talents.firstWhere((Talent t) =>
                      t.talent_tree_id == talentName || t.name == talentName);
                  return new TalentCard(talent, key: new Key(talentName));
                }).toList(),
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new IconButton(
                  color: Colors.white,
                  disabledColor: Colors.grey,
                  icon: new Icon(Icons.arrow_back),
                  tooltip: AppStrings.of(context).previousTalent(),
                  onPressed: () => _nextPage(-1),
                ),
                new TabPageSelector(
                    controller: _tabController,
                    color: Theme.of(context).primaryColor,
                    selectedColor: Colors.white),
                new IconButton(
                  color: Colors.white,
                  icon: new Icon(Icons.arrow_forward),
                  tooltip: AppStrings.of(context).nextTalent(),
                  onPressed: () => _nextPage(1),
                ),
              ],
            )
          ],
        ));
  }
}
