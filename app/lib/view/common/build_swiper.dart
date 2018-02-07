import 'dart:async';

import 'package:flutter/material.dart' hide Hero;
import 'package:flutter/services.dart';
import 'package:heroes_companion/services/exception_service.dart';
import 'package:heroes_companion/view/common/talent_card.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:hots_dog_api/hots_dog_api.dart' hide Talent;

class BuildSwiper extends StatefulWidget {
  final Hero hero;
  final BuildStatistics buildWinRates;

  BuildSwiper(
    this.hero,
    this.buildWinRates, {
    key,
  })
      : super(key: key);

  @override
  State createState() => new _BuildSwiperState();
}

class _BuildSwiperState extends State<BuildSwiper>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  static final _platform =
      const MethodChannel('com.heroescompanion.app/screen');

  Future _setScreenNoSleep() async {
    try {
      await _platform.invokeMethod('setScreenNoSleep');
    } on PlatformException catch (e) {
        new ExceptionService()
        .reportError(e);
    }
  }

  Future _setScreenCanSleep() async {
    try {
      await _platform.invokeMethod('setScreenCanSleep');
    } on PlatformException catch (e) {
        new ExceptionService()
        .reportError(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _setScreenNoSleep();
    _tabController = new TabController(
        vsync: this, length: widget.buildWinRates.talents_names.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _setScreenCanSleep();
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
                children: <Widget>[
                  new IconButton(
                    icon: new Icon(Icons.first_page),
                    color: Colors.white,
                    onPressed: () => _firstPage(),
                    tooltip: 'Go to first talent',
                  )
                ],
              ),
            ),
            new Flexible(
              child: new TabBarView(
                key: new Key('${widget.hero.name}_swiper_tab_bar_view'),
                controller: _tabController,
                children:
                    widget.buildWinRates.talents_names.map((String talentName) {
                  Talent talent = widget.hero.talents
                      .firstWhere((Talent t) => t.talent_tree_id == talentName);
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
                  tooltip: 'Previous talent',
                  onPressed: () => _nextPage(-1),
                ),
                new TabPageSelector(
                    controller: _tabController,
                    color: Theme.of(context).primaryColor,
                    selectedColor: Colors.white),
                new IconButton(
                  color: Colors.white,
                  icon: new Icon(Icons.arrow_forward),
                  tooltip: 'Next talent',
                  onPressed: () => _nextPage(1),
                ),
              ],
            )
          ],
        ));
  }
}
