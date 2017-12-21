import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hots_dog_api/hots_dog_api.dart';

class BuildPrompt extends StatelessWidget {
  final bool _isCurrentBuild;
  final dynamic onTap;
  final WinLossCount winLossCount;

  BuildPrompt(
    this._isCurrentBuild,
    this.winLossCount,
    this.onTap,
  );

  @override
  Widget build(BuildContext context) {
    return new Builder(
      builder: (BuildContext context){
        if (winLossCount != null && !_isCurrentBuild) {
          return new GestureDetector(
              onTap: onTap,
              child: new Container(
                  constraints: new BoxConstraints.expand(height: 36.0),
                  color: _isCurrentBuild
                      ? Theme.of(context).errorColor
                      : Theme.of(context).accentColor,
                  child: new Center(
                      child: new Text(
                        'Showing previous build data'.toUpperCase(),
                      style: Theme.of(context).textTheme.body1.copyWith(
                        fontWeight: FontWeight.w600,
                      )
                      .apply(fontSizeFactor: 0.9),
                  ))));
        } else if (winLossCount != null && _isCurrentBuild && (winLossCount.losses + winLossCount.wins < 1300)){
          new Future<Null>.delayed(new Duration(seconds: 1), () {
            Scaffold.of(context).showSnackBar(
              new SnackBar(
                content: new Text('Not many games have been played this patch. Would you like to see the builds for the previous patch?'),
                duration: new Duration(seconds: 10),
                action: new SnackBarAction(
                  onPressed: onTap,
                  label: 'Show Me',
                ),
              )
            );
          });
          
          
        }
        return new Container(
          height: 0.0,
        );
      },
    );
  }
}
