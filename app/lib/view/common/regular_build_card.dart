import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Hero;
import 'package:heroes_companion/services/exception_service.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:url_launcher/url_launcher.dart';

class RegularBuildCard extends StatefulWidget{
  final Build regularBuild;
  final dynamic _onPressed;
  final Hero hero;
  final dynamic showTalentBottomSheet;

  RegularBuildCard(this.regularBuild, this._onPressed, this.hero, this.showTalentBottomSheet);

  @override
  State<StatefulWidget> createState() => new _RegularBuildCardState();
}


class _RegularBuildCardState extends State<RegularBuildCard> {
  bool _isShowingDescription = false;

  @override
  Widget build(BuildContext context) {
    bool isPhone = MediaQuery.of(context).size.width < 600;
    TextTheme style = Theme.of(context).textTheme;

    List<Talent> talents = [];

    try {
      widget.regularBuild.talentTreeIds
                      .forEach((talentTreeId) {
                        Talent talent = widget.hero.talents.firstWhere((t) => t.talent_tree_id == talentTreeId);
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
              new Text(widget.regularBuild.source, style: style.body2),
              widget.regularBuild.tagline != null ? new Text(widget.regularBuild.tagline, style: style.body1, maxLines: 3,) : new Container(),
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
                      child: const Text('MORE INFO'),
                      onPressed: () async {
                         if (await canLaunch(widget.regularBuild.url)) {
                            await launch(widget.regularBuild.url);
                          } else {
                            throw new Exception('Could not launch ${widget.regularBuild.url}');
                          }
                      }
                    ),
                    new FlatButton(
                      child: const Text('PLAY BUILD'),
                      onPressed: () => widget._onPressed(context, new HeroBuild(widget.hero.hero_id, widget.regularBuild.talentTreeIds)),
                    ),
                    new IconButton(
                      tooltip: 'Show Description',
                      icon: _isShowingDescription ? const Icon(Icons.expand_less) : const Icon(Icons.expand_more),
                      onPressed: () => setState(() {_isShowingDescription = !_isShowingDescription;}),
                    )
                  ],
                ),
              ),
              _isShowingDescription ? new Padding(
                padding: new EdgeInsets.only(top: 8.0),
                child: new Text(widget.regularBuild.description),
              ) : new Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneTalent(BuildContext context, Talent talent) {
    return new Expanded(
      child: new GestureDetector(
        onTap: () => widget.showTalentBottomSheet(context, talent),
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
        onTap: () => widget.showTalentBottomSheet(context, talent),
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