import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Hero;
import 'package:heroes_companion/services/exception_service.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';

class BuildCard extends StatelessWidget{
  final StatisticalHeroBuild statisticalBuild;
  final String type;
  final dynamic _onPressed;
  final Hero hero;
  final dynamic showTalentBottomSheet;

  BuildCard(this.statisticalBuild, this._onPressed, this.hero, this.showTalentBottomSheet, {this.type,} );

  List<Widget> buildCardTopText(BuildContext context)
 {

  TextStyle style = Theme.of(context).textTheme.body1;
   List<Widget> widgets = [];
   if (type != null) {
     widgets.add(new Text(type, style: style.apply(fontWeightDelta: 1),));
   }
   widgets.add(new Text(
                      '${(statisticalBuild.winRate * 100).toStringAsFixed(2)} Win %',
                      style: style));
  widgets.add(new Text('${statisticalBuild.gamesPlayed} Games Played',
                      style: style));
                    return widgets;
                    
 }

  @override
  Widget build(BuildContext context) {
    bool isPhone = MediaQuery.of(context).size.width < 600;

    List<Talent> talents = [];

    try {
      statisticalBuild.build.talentNames
                      .forEach((talentName) {
                        Talent talent = hero.talents.firstWhere((t) => t.talent_tree_id == talentName || t.name == talentName);
                        talents.add(talent);
                      });
    } catch (e) {
      new ExceptionService()
       .reportError(e);
      return new Container();
    }
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
                  children: buildCardTopText(context),
              ),
              new Container(
                height: 16.0,
              ),
              new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: talents.map((Talent t) => isPhone ? _buildPhoneTalent(context, t) : _buildTabletTalent(context, t)).toList()
              ),
              new ButtonTheme.bar(
                child: new ButtonBar(
                  children: <Widget>[
                    new FlatButton(
                      child: const Text('PLAY BUILD'),
                      onPressed: () => _onPressed(context, statisticalBuild),
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
                        'https://images.heroescompanion.com/talents/${talent.icon_file_name}'))
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
                        'https://images.heroescompanion.com/talents/${talent.icon_file_name}')),
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