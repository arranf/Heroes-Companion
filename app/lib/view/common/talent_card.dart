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
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      talent.name,
                      style: Theme
                          .of(context)
                          .textTheme
                          .body2
                          .apply(fontSizeFactor: 2.0),
                    ),
                    new Image.asset(
                        'assets/images/talents/${talent.icon_file_name}')
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
                  child: new Text(talent.description),
                ),
              ],
            ),
          ))),
    );
  }
}
