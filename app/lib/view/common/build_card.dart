import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Hero;
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:hots_dog_api/hots_dog_api.dart' hide Talent;

class BuildCard extends StatelessWidget{
  final BuildStatistics buildStatistics;
  final String type;
  final dynamic _onPressed;
  final Hero hero;
  final dynamic showTalentBottomSheet;

  BuildCard(this.buildStatistics, this.type, this._onPressed, this.hero, this.showTalentBottomSheet);


  @override
  Widget build(BuildContext context) {
    bool isPhone = MediaQuery.of(context).size.width < 600;

    TextStyle style = new TextStyle(fontSize: 16.0, fontWeight: Theme.of(context).textTheme.body1.fontWeight);
    return new Container(
      // Tablets get padding
      padding: !isPhone ? new EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0) : EdgeInsets.zero,
      child: new Card(
        child: new Container(
          padding: new EdgeInsets.symmetric(horizontal: 8.0).add(new EdgeInsets.only(top: 16.0, bottom: 8.0)),
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(type, style: style.apply(fontWeightDelta: 1),),
                    new Text(
                      '${(buildStatistics.win_rate * 100).toStringAsFixed(2)} Win %',
                      style: style),
                    new Text('${buildStatistics.total_games_played} Games Played',
                      style: style),
                  ],
              ),
              new Container(
                height: 16.0,
              ),
              new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: buildStatistics.talents_names
                      .map((talentName) {
                        Talent talent = hero.talents.firstWhere((t) => t.talent_tree_id == talentName);
                        return isPhone ? _buildPhoneTalent(context, talent) : _buildTabletTalent(context, talent);
                      })
                      .toList()
              ),
              new ButtonTheme.bar(
                child: new ButtonBar(
                  children: <Widget>[
                    new FlatButton(
                      child: const Text('PLAY BUILD'),
                      onPressed: () => _onPressed(context, buildStatistics),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneTalent(BuildContext context, Talent talent) {
    return new Expanded(
      child: new GestureDetector(
        onTap: () => showTalentBottomSheet(context, talent),
         child: talent.have_asset
                ? new Image.asset(
                    'assets/images/talents/${talent.icon_file_name}')
                : new Image(
                    image: new CachedNetworkImageProvider(
                        'https://s3.eu-west-1.amazonaws.com/data.heroescompanion.com/images/talents/${talent.icon_file_name}'))
          ),
        );
  }

  Widget _buildTabletTalent(BuildContext context, Talent talent) {
    return new GestureDetector(
        onTap: () => showTalentBottomSheet(context, talent),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            talent.have_asset
                ? new Image.asset(
                    'assets/images/talents/${talent.icon_file_name}')
                : new Image(
                    image: new CachedNetworkImageProvider(
                        'https://s3.eu-west-1.amazonaws.com/data.heroescompanion.com/images/talents/${talent.icon_file_name}')),
            new Container(
              height: 4.0,
            ),
            new Text(
              talent.name,
              maxLines: 1,
            )
          ],
        ));
  }

}