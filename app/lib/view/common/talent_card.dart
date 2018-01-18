import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';

class TalentCard extends StatelessWidget {
  final Talent talent;
  final bool have_assets;

  TalentCard(this.talent, this.have_assets, {key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Padding(
          padding: new EdgeInsets.all(8.0),
          child: new Card(
              child: new Padding(
            padding: new EdgeInsets.all(16.0),
            child: new Column(
              key: new Key(talent.name + '_talent_card' + '_column'),
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Flexible(
                      child: new Text(
                        talent.name,
                        style: Theme
                            .of(context)
                            .textTheme
                            .body2
                            .apply(fontSizeFactor: 2.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    have_assets
                        ? new Image.asset(
                            'assets/images/talents/${talent.icon_file_name}')
                        : new Image(image: new CachedNetworkImageProvider(
                            'https://s3.eu-west-1.amazonaws.com/data.heroescompanion.com/images/talents/${talent.icon_file_name}'))
                  ],
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: 16.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Padding(
                        padding: new EdgeInsets.only(right: 8.0),
                        child: new Text('Level ${talent.level}',
                            style: Theme.of(context).textTheme.title),
                      ),
                      new Text(
                        '(${talent.sort_order})',
                        style: Theme
                            .of(context)
                            .textTheme
                            .body2
                            .apply(fontSizeDelta: 4.0),
                      )
                    ],
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: 16.0),
                  child: new Text(talent.description,
                      style: Theme
                          .of(context)
                          .textTheme
                          .body1
                          .apply(fontSizeFactor: 1.2)),
                ),
              ],
            ),
          ))),
    );
  }
}
