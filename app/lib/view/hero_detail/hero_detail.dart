import 'package:flutter/material.dart' hide Hero;
import 'package:heroes_companion/models/build_sort.dart';
import 'package:heroes_companion/models/overflow_choices.dart';
import 'package:heroes_companion/view/common/app_loading_container.dart';
import 'package:heroes_companion/view/hero_detail/build_prompt.dart';
import 'package:heroes_companion/view/common/build_swiper.dart';
import 'package:heroes_companion/view/common/loading_view.dart';
import 'package:heroes_companion/view/hero_detail/regular_build_list.dart';
import 'package:heroes_companion/view/hero_detail/statistical_build_list.dart';
import 'package:heroes_companion/i18n/strings.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:meta/meta.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HeroDetail extends StatefulWidget {
  final Hero hero;
  final bool isCurrentBuild;
  final bool canOfferPreviousBuild;
  final HeroWinRate heroWinRate;
  final List<StatisticalHeroBuild> statisticalBuilds;
  final List<Build> regularBuilds;
  final dynamic favorite;
  final dynamic buildSwitch;
  final Patch patch;
  final String heroPatchNotesUrl;

  HeroDetail(
    this.hero, {
    key,
    @required this.canOfferPreviousBuild,
    @required this.favorite,
    this.heroWinRate,
    this.statisticalBuilds,
    this.regularBuilds,
    this.isCurrentBuild,
    this.buildSwitch,
    this.patch,
    this.heroPatchNotesUrl,
  })
      : super(key: key);

  @override
  _HeroDetailState createState() => new _HeroDetailState();
}

class _HeroDetailState extends State<HeroDetail>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Tab> _tabs = new List<Tab>();
  BuildSort buildSort = BuildSort.playrate;

  @override
  void initState() {
    super.initState();
    _buildTabs();
    _tabController = new TabController(vsync: this, length: _tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new AppLoading(builder: (context, loading) {
      return _buildDetail(context, loading);
    });
  }

  Widget _buildPhoneTitleRow(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    int scaleFactor = (mediaQueryData.size.width / 40).floor();
    return new Container(
      key: new Key(widget.hero.name + '_title_row'),
      padding: new EdgeInsets.symmetric(horizontal: 4.0 * scaleFactor)
          .add(new EdgeInsets.only(bottom: 8.0)),
      color: Theme.of(context).primaryColor,
      child: new Row(
        children: <Widget>[
          new CircleAvatar(
            backgroundImage: widget.hero.have_assets
                ? new AssetImage(
                    'assets/images/heroes/${widget.hero.icon_file_name}')
                : new CachedNetworkImageProvider(
                    'https://images.heroescompanion.com/heroes/${widget.hero.icon_file_name}'),
            radius: 45.0,
          ),
          new Container(
            width: 40.0,
          ),
          new Container(
            padding: new EdgeInsets.only(top: 4.0),
            height: 125.0,
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Text(widget.hero.name,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline
                          .apply(color: Colors.white)),
                  new Text(
                    '${widget.hero.type} ${widget.hero.role}',
                    style: Theme
                        .of(context)
                        .textTheme
                        .subhead
                        .apply(color: Colors.white),
                  ),
                  new Container(
                    height: 20.0,
                  ),
                  (widget.heroWinRate != null)
                      ? new Container(
                          child: new Column(
                            children: <Widget>[
                              new Text(
                                widget.heroWinRate != null
                                    ? '${widget.heroWinRate.winPercentage.toStringAsFixed(1)} ${AppStrings.of(context).win()} %'
                                    : ' ',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline
                                    .apply(color: Colors.white),
                              ),
                              new Text(
                                  widget.heroWinRate != null
                                      ? '${(widget.heroWinRate.gamesPlayed).toString()} ${AppStrings.of(context).gamesPlayed()}'
                                      : ' ',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .body1
                                      .apply(color: Colors.white))
                            ],
                          ),
                        )
                      : new Container(),
                ]),
          )
        ],
      ),
    );
  }

  Widget _buildTabletTitleRow(BuildContext context) {
    return new Container(
      key: new Key(widget.hero.name + '_title_row'),
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
                  backgroundImage: widget.hero.have_assets
                      ? new AssetImage(
                          'assets/images/heroes/${widget.hero.icon_file_name}')
                      : new CachedNetworkImageProvider(
                          'https://images.heroescompanion.com/images/heroes/${widget.hero.icon_file_name}'),
                  radius: 45.0,
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: 4.0)
                      .add(new EdgeInsets.only(left: 40.0)),
                  child: new Column(children: [
                    new Text(widget.hero.name,
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline
                            .apply(color: Colors.white)),
                    new Text(
                      '${widget.hero.type} ${widget.hero.role}',
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
                  widget.heroWinRate != null
                      ? '${widget.heroWinRate.winPercentage.toStringAsFixed(1)} Win %'
                      : ' ',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline
                      .apply(color: Colors.white),
                ),
                new Text(
                    widget.heroWinRate != null
                        ? '${(widget.heroWinRate.gamesPlayed).toString()} ${AppStrings.of(context).gamesPlayed()}'
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

  void _playBuild(BuildContext context, HeroBuild heroBuild) {
    Navigator.of(context).push(new PageRouteBuilder(
          pageBuilder: (context, a1, a2) => new BuildSwiper(
                widget.hero,
                heroBuild,
                key: new Key(
                    '${widget.hero.name}_${build.hashCode}_build_swiper'),
              ),
        ));
  }

  void showTalentBottomSheet(BuildContext context, Talent talent) {
    showModalBottomSheet<Null>(
        context: context,
        builder: (BuildContext context) {
          return new Container(
            key: new Key('${talent.tool_tip_id}_container'),
            child: new Padding(
                padding: const EdgeInsets.all(32.0),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Flexible(
                          child: new Text(
                            talent.name,
                            style: Theme.of(context).textTheme.headline,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 2,
                          ),
                        ),
                        new Padding(
                          padding: new EdgeInsets.only(left: 8.0),
                          child: talent.have_asset
                              ? new Image.asset(
                                  'assets/images/talents/${talent.icon_file_name}')
                              : new Image(
                                  image: new CachedNetworkImageProvider(
                                      'https://images.heroescompanion.com/talents/${talent.icon_file_name}')),
                        ),
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

  void _buildTabs() {
    this._tabs.add(new Tab(
          text: AppStrings.of(context).statisticalBuilds(),
        ));
    this._tabs.add(new Tab(
          text: AppStrings.of(context).recommendedBuilds(),
        ));
  }

  Widget _buildPhoneView(BuildContext context, bool isLoading) {
    return new Container(
        child: new Column(
      children: <Widget>[
        !widget.isCurrentBuild
            ? new BuildPrompt(
                widget.isCurrentBuild,
                widget.patch.patchName,
                widget.buildSwitch,
                key: new Key('${widget.hero.name}_previous_build_prompt'),
              )
            : new Container(),
        _buildPhoneTitleRow(context),
        isLoading
            ? new Container()
            : new TabBar(
                tabs: _tabs,
                controller: _tabController,
                labelColor: Theme.of(context).textTheme.title.color,
                unselectedLabelColor:
                    Theme.of(context).textTheme.display1.color,
              ),
        isLoading
            ? new Expanded(child: new LoadingView())
            : new Expanded(
                child: new TabBarView(
                  controller: _tabController,
                  key: new Key('${widget.hero.name}_tab_view'),
                  children: <Widget>[
                    new StatisticalBuildList(
                        widget.hero,
                        _playBuild,
                        showTalentBottomSheet,
                        widget.statisticalBuilds,
                        buildSort),
                    new RegularBuildList(widget.hero, _playBuild,
                        showTalentBottomSheet, widget.regularBuilds),
                  ],
                ),
              )
      ],
    ));
  }

  Widget _buildTabletView(BuildContext context, bool isLoading) {
    return new Column(
      children: <Widget>[
        widget.canOfferPreviousBuild
            ? new BuildPrompt(
                widget.isCurrentBuild,
                widget.patch.patchName,
                widget.buildSwitch,
                key: new Key('${widget.hero.name}_previous_build_prompt'),
              )
            : new Container(),
        _buildTabletTitleRow(context),
        // TODO refactor reused logic
        isLoading
            ? new Expanded(child: new LoadingView())
            : new Expanded(
                child: new TabBarView(
                  controller: _tabController,
                  key: new Key('${widget.hero.name}_tab_view'),
                  children: <Widget>[
                    new StatisticalBuildList(
                        widget.hero,
                        _playBuild,
                        showTalentBottomSheet,
                        widget.statisticalBuilds,
                        buildSort),
                  ],
                ),
              )
      ],
    );
  }

  Widget _buildDetail(BuildContext context, bool isLoading) {
    final List<OverflowChoice> overflowChoices = [
      OverflowChoice.HeroPatchNotes
    ];
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.hero.name),
          actions: [
            new IconButton(
              tooltip: widget.hero.is_favorite
                  ? '${AppStrings.of(context).unfavorite()} ${widget.hero.name}'
                  : '${AppStrings.of(context).favoriteTooltip()} ${widget.hero.name}',
              icon: new Icon(Icons.favorite,
                  color: widget.hero.is_favorite
                      ? Colors.red
                      : Theme.of(context).buttonColor),
              onPressed: () => widget.favorite(widget.hero),
            ),
            new PopupMenuButton(
              onSelected: (Object choice) {
                if (choice is OverflowChoice) {
                  OverflowChoice.handleChoice(choice, context,
                      patchNotesUrl: widget.heroPatchNotesUrl); // overflow menu
                } else if (choice is BuildSort) {
                  BuildSort newBuildSort = choice == BuildSort.playrate
                      ? BuildSort.winrate
                      : BuildSort.playrate;
                  setState(() {
                    buildSort = newBuildSort;
                  });
                } else if (choice == 'Switch Build') {
                  widget.buildSwitch();
                } else {
                  throw new Exception('Unknown action');
                }
              },
              itemBuilder: (BuildContext context) {
                List<PopupMenuItem> items =
                    overflowChoices.map((OverflowChoice choice) {
                  return new PopupMenuItem(
                    value: choice,
                    child: new Text(choice.name),
                  );
                }).toList();
                items.add(new PopupMenuItem(
                  value: buildSort,
                  child: new Text(
                      '${buildSort == BuildSort.winrate ? AppStrings.of(context).sortByPopularity() : AppStrings.of(context).sortByWinRate()}'),
                ));
                if (widget.canOfferPreviousBuild) {
                  items.add(new PopupMenuItem(
                    value: 'Switch Build',
                    child: new Text(widget.isCurrentBuild
                        ? AppStrings.of(context).seeCurrentPatchData()
                        : AppStrings.of(context).seePreviousPatchData()),
                  ));
                }
                return items;
              },
            ),
          ],
        ),
        body: MediaQuery.of(context).size.width < 600
            ? _buildPhoneView(context, isLoading)
            : _buildTabletView(context, isLoading));
  }
}
