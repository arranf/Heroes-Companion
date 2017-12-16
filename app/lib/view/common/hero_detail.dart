import 'package:flutter/material.dart' hide Hero;
import 'package:heroes_companion/view/common/app_loading_container.dart';
import 'package:heroes_companion/view/common/loading_view.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:hots_dog_api/hots_dog_api.dart';
import 'package:meta/meta.dart';

class HeroDetail extends StatelessWidget {
  final Hero hero;
  final WinLossCount winLossCount;
  final BuildWinRates buildWinRates;
  final dynamic favorite;

  HeroDetail(
    this.hero, {
    key,
    @required this.favorite,
    this.winLossCount,
    this.buildWinRates,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new AppLoading(builder: (context, loading) {
      return loading ? new LoadingView() : _buildDetail(context);
    });
  }

  Widget _buildDetail(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(hero.name),
        actions: [
          new IconButton(
            tooltip: hero.is_favorite
                ? 'Unfavorite ${hero.name}'
                : 'Favorite ${hero.name}',
            icon: new Icon(Icons.favorite,
                color: hero.is_favorite
                    ? Colors.red
                    : Theme.of(context).buttonColor),
            onPressed: () => this.favorite(this.hero),
          ),
        ],
      ),
      body: new Padding(
        padding: new EdgeInsets.all(16.0),
        child: new ListView(
          children: [
            new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Padding(
                  padding: new EdgeInsets.only(right: 8.0),
                  child: new Checkbox(
                    value: hero.is_owned,
                    onChanged: (value) => debugPrint('Collect'),
                  ),
                ),
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Padding(
                        padding: new EdgeInsets.only(
                          top: 8.0,
                          bottom: 16.0,
                        ),
                        child: new Text(
                          hero.name,
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ),
                      new Text(
                        hero.role,
                        style: Theme.of(context).textTheme.subhead,
                      ),
                      new Text(winLossCount != null
                          ? "Win Percentage: ${winLossCount.winPercentange().toString()}"
                          : ''),
                      new Text(buildWinRates != null &&
                              buildWinRates.winning_builds.length > 0
                          ? buildWinRates.winning_builds
                              .reduce((a, b) => a.win_rate > b.win_rate ? a : b)
                              .talents_names
                              .map((id) => buildWinRates.talents
                                  .firstWhere((t) => t.id == id))
                              .map((t) => t.name)
                              .join('\n')
                          : '')
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
