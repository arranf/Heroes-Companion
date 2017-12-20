import 'package:flutter/material.dart' hide Hero;
import 'package:heroes_companion/view/common/app_loading_container.dart';
import 'package:heroes_companion/view/common/loading_view.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:hots_dog_api/hots_dog_api.dart' hide Talent;
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

  Widget _buildTitleRow(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.only(left: 64.0, bottom: 8.0),
      color: Theme.of(context).primaryColor,
      child: new Row(
        children: <Widget>[
          new CircleAvatar(
            backgroundImage:
                new AssetImage('assets/images/heroes/${hero.icon_file_name}'),
            radius: 45.0,
          ),
          new Container(
            width: 40.0,
          ),
          new Padding(
            padding: new EdgeInsets.only(top: 4.0),
            child: new Column(children: [
              new Text(hero.name,
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline
                      .apply(color: Colors.white)),
              new Text(
                '${hero.type} ${hero.role}',
                style: Theme
                    .of(context)
                    .textTheme
                    .subhead
                    .apply(color: Colors.white),
              ),
              new Container(
                height: 20.0,
              ),
              new Text(
                winLossCount != null
                    ? '${winLossCount.winPercentange().toStringAsFixed(1)} Win %'
                    : ' ',
                style: Theme
                    .of(context)
                    .textTheme
                    .headline
                    .apply(color: Colors.white),
              ),
              new Text(
                  winLossCount != null
                      ? '${(winLossCount.wins + winLossCount.losses).toString()} games played'
                      : ' ',
                  style: Theme
                      .of(context)
                      .textTheme
                      .body1
                      .apply(color: Colors.white))
            ]),
          )
        ],
      ),
    );
  }

  Widget _buildTalentRows(BuildContext context) {
    if (buildWinRates != null) {
      List<Widget> children = [];
      if (buildWinRates.winning_builds != null) {
        List<BuildStatistics> interestingWinningBuilds =
            new List<BuildStatistics>.from(buildWinRates.winning_builds
                .where((b) => b.talents_names.length == 7));
        if (interestingWinningBuilds.length > 0) {
          children.add(new Text(
            'Winning Builds',
            style: Theme.of(context).textTheme.headline,
          ));
          List<Widget> winningBuilds = new List.generate(
              interestingWinningBuilds.length,
              (i) => _buildTalentRow(context, interestingWinningBuilds[i]));
          children.addAll(winningBuilds);
        }
      }

      if (buildWinRates.popular_builds != null) {
        List<BuildStatistics> interestingPopularBuilds =
            new List<BuildStatistics>.from(buildWinRates.popular_builds
                .where((b) => b.talents_names.length == 7));
        if (interestingPopularBuilds.length > 0) {
          children.add(new Text(
            'Popular Builds',
            style: Theme.of(context).textTheme.headline,
          ));
          List<Widget> popularBuilds = new List.generate(
              interestingPopularBuilds.length,
              (i) => _buildTalentRow(context, interestingPopularBuilds[i]));
          children.addAll(popularBuilds);
        } else {
          children.add(new Text(
            'No Popular Builds for ${hero.name}',
            style: Theme.of(context).textTheme.headline,
          ));
        }
      }

      return new Column(children: children);
    }
    return new Container();
  }

  Widget _buildTalentRow(BuildContext context, BuildStatistics build) {
    return new Padding(
        padding: new EdgeInsets.all(8.0),
        child: new Column(
          key: new Key(build.hashCode.toString()),
          children: [
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.symmetric(horizontal: 4.0),
                  child: new Text(
                      '${(build.win_rate * 100).toStringAsFixed(2)} Win %'),
                ),
                new Padding(
                  padding: new EdgeInsets.symmetric(horizontal: 4.0),
                  child: new Text('${build.total_games_played} Games Played'),
                )
              ],
            ),
            new Container(
              height: 4.0,
            ),
            new FittedBox(
                child: new Row(
                    children: new List.generate(build.talents_names.length,
                        (i) => _buildTalent(context, build.talents_names[i]))))
          ],
        ));
  }

  Widget _buildTalent(BuildContext context, String talentName) {
    Talent talent =
        hero.talents.firstWhere((t) => t.talent_tree_id == talentName);
    return new Column(
      key: new Key(talentName),
      children: [
        new Text(
          talent.sort_order.toString(),
          style: new TextStyle(fontWeight: FontWeight.w600),
        ),
        new Tooltip(
          message: 'Level ${talent.level}: ${talent.name}',
          child:
              new Image.asset('assets/images/talents/${talent.icon_file_name}'),
        ),
      ],
    );
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
          padding: new EdgeInsets.all(8.0),
          child: new ListView(
            children: [
              _buildTitleRow(context),
              new Container(
                height: 24.0,
              ),
              _buildTalentRows(context)
            ],
          ),
        ));
  }
}
