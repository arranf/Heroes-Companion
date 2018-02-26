import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';

class TalentCard extends StatelessWidget {
  final Talent talent;

  TalentCard(this.talent, {key}) : super(key: key);

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
                    new AnimatedContainer(
                      width: 64.0,
                      height: 64.0,
                      duration: kThemeChangeDuration,
                      decoration: new BoxDecoration(
                        color: Colors.grey,
                        image: new DecorationImage(
                          image: talent.have_asset
                        ? new AssetImage(
                            'assets/images/talents/${talent.icon_file_name}')
                        : new CachedNetworkImageProvider(
                                'https://images.heroescompanion.com/talents/${talent.icon_file_name}')
                        ),
                        shape: BoxShape.rectangle,
                      )
                    )
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
