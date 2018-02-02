import 'package:flutter/material.dart' hide Hero;
import 'package:heroes_companion/view/common/app_loading_container.dart';
import 'package:heroes_companion/view/common/build_card.dart';
import 'package:heroes_companion/view/common/build_prompt.dart';
import 'package:heroes_companion/view/common/build_swiper.dart';
import 'package:heroes_companion/view/common/loading_view.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:hots_dog_api/hots_dog_api.dart' hide Talent;
import 'package:meta/meta.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HeroDetail extends StatelessWidget {
  final Hero hero;
  final bool isCurrentBuild;
  final WinLossCount winLossCount;
  final BuildWinRates buildWinRates;
  final String buildNumber;
  final dynamic favorite;
  final dynamic buildSwitch;

  HeroDetail(
    this.hero, {
    key,
    @required this.favorite,
    this.winLossCount,
    this.buildWinRates,
    this.isCurrentBuild,
    this.buildNumber,
    this.buildSwitch,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new AppLoading(builder: (context, loading) {
      return loading ? new LoadingView() : _buildDetail(context);
    });
  }

  Widget _buildPhoneTitleRow(BuildContext context) {
    return new Container(
      key: new Key(hero.name + '_title_row'),
      padding: new EdgeInsets.only(left: 64.0, bottom: 8.0),
      color: Theme.of(context).primaryColor,
      child: new Row(
        children: <Widget>[
          new CircleAvatar(
            backgroundImage: hero.have_assets
                ? new AssetImage('assets/images/heroes/${hero.icon_file_name}')
                : new CachedNetworkImageProvider(
                    'https://s3.eu-west-1.amazonaws.com/data.heroescompanion.com/images/heroes/${hero.icon_file_name}'),
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

  Widget _buildTabletTitleRow(BuildContext context) {
    return new Container(
      key: new Key(hero.name + '_title_row'),
      padding: new EdgeInsets.only(left: 64.0, bottom: 8.0, top: 8.0),
      color: Theme.of(context).primaryColor,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // This is the avatar and name
          new Container(
            child: new Row(
              children: <Widget>[
                new CircleAvatar(
                  backgroundImage: hero.have_assets
                      ? new AssetImage(
                          'assets/images/heroes/${hero.icon_file_name}')
                      : new CachedNetworkImageProvider(
                          'https://s3.eu-west-1.amazonaws.com/data.heroescompanion.com/images/heroes/${hero.icon_file_name}'),
                  radius: 45.0,
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: 4.0)
                      .add(new EdgeInsets.only(left: 40.0)),
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
                    )
                  ]),
                )
              ],
            ),
          ),
          // This is the winrate and number of games played
          new Padding(
            padding: new EdgeInsets.only(top: 4.0, right: 20.0),
            child: new Column(
              children: <Widget>[
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
              ],
            ),
          )
        ],
      ),
    );
  }

  void _playBuild(BuildContext context, BuildStatistics buildStatistics) {
    Navigator.of(context).push(new PageRouteBuilder(
                              pageBuilder: (context, a1, a2) => new BuildSwiper(
                                    hero,
                                    buildStatistics,
                                    key: new Key(
                                        '${hero.name}_${build.hashCode}_build_swiper'),
                                  ),
                            ));
  }

  Widget _buildTalentCards(BuildContext context) {
    if (buildWinRates != null) {
      List<Widget> children = [];
      if (buildWinRates.winning_builds != null) {
        List<BuildStatistics> interestingWinningBuilds =
            new List<BuildStatistics>.from(buildWinRates.winning_builds
                .where((b) => b.talents_names.length == 7));
        if (interestingWinningBuilds.length > 0) {
          children.addAll(interestingWinningBuilds
              .map((BuildStatistics b) => new BuildCard(b, 'Winning Build', _playBuild, hero, showTalentBottomSheet))
              .toList());
        }
      }

      if (buildWinRates.popular_builds != null) {
        List<BuildStatistics> interestingPopularBuilds =
            new List<BuildStatistics>.from(buildWinRates.popular_builds
                .where((b) => b.talents_names.length == 7));
        if (interestingPopularBuilds.length > 0) {
          children.addAll(interestingPopularBuilds
              .map((b) => new BuildCard(b, 'Popular Build', _playBuild, hero, showTalentBottomSheet))
              .toList());
        }
      }
      return new ListView(
        key: new Key(hero.name + '_talent_rows_tablet'),
        children: children,
      );
    }
    return new Container();
  }

  void showTalentBottomSheet(BuildContext context, Talent talent) {
    showModalBottomSheet<Null>(
        context: context,
        builder: (BuildContext context) {
          return new Container(
            child: new Padding(
                padding: const EdgeInsets.all(32.0),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Text(
                          talent.name,
                          style: Theme.of(context).textTheme.headline,
                        ),
                        talent.have_asset
                            ? new Image.asset(
                                'assets/images/talents/${talent.icon_file_name}')
                            : new Image(
                                image: new CachedNetworkImageProvider(
                                    'https://s3.eu-west-1.amazonaws.com/data.heroescompanion.com/images/talents/${talent.icon_file_name}'))
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    new Container(
                      height: 16.0,
                    ),
                    new Text(talent.description)
                  ],
                )),
          );
        });
  }

  List<Widget> _buildTabs(BuildContext context) {
    List<Tab> tabs = new List<Tab>();
    if (buildWinRates != null &&
        buildWinRates.winning_builds != null &&
        buildWinRates.winning_builds.any((b) => b.talents_names.length == 7)) {
      tabs.add(new Tab(
        key: new Key('winning_build_tab'),
        text: 'Winning Builds',
      ));
    }

    if (buildWinRates != null &&
        buildWinRates.popular_builds != null &&
        buildWinRates.popular_builds.any((b) => b.talents_names.length == 7)) {
      tabs.add(new Tab(
        key: new Key('popular_build_tab'),
        text: 'Popular Builds',
      ));
    }

    return tabs;
  }

  Widget _buildPhoneView(BuildContext context) {
    List<Tab> tabs = _buildTabs(context);
    return new DefaultTabController(
        key: new Key('tab_controller_${tabs.hashCode}'),
        length: tabs.length,
        initialIndex: 0,
        child: new Column(
          children: <Widget>[
            new BuildPrompt(
              isCurrentBuild,
              winLossCount,
              buildSwitch,
              key: new Key('${hero.name}_previous_build_prompt'),
            ),
            _buildPhoneTitleRow(context),
            new Expanded(child: _buildTalentCards(context))
          ],
        ));
  }

  Widget _buildTabletView(BuildContext context) {
    return new Column(
      children: <Widget>[
        new BuildPrompt(isCurrentBuild, winLossCount, buildSwitch),
        _buildTabletTitleRow(context),
        new Expanded(child: _buildTalentCards(context))
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
              onPressed: () => favorite(hero),
            ),
          ],
        ),
        body: MediaQuery.of(context).size.width < 600
            ? _buildPhoneView(context)
            : _buildTabletView(context));
  }
}
