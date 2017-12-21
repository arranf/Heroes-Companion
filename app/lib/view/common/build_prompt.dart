import 'package:flutter/material.dart';
import 'package:hots_dog_api/hots_dog_api.dart';

class BuildPrompt extends StatelessWidget{
  final bool _isCurrentBuild;
  final dynamic onTap;
  final WinLossCount winLossCount;

  BuildPrompt(this._isCurrentBuild, this.winLossCount, this.onTap,);

  @override
  Widget build(BuildContext context) {
    if (winLossCount != null && winLossCount.wins + winLossCount.losses < 800) { 
      return new GestureDetector(
        onTap: onTap,
        child: 
        new Container(
          constraints: new BoxConstraints.expand(height: 36.0),
          color: _isCurrentBuild ? Theme.of(context).errorColor : Theme.of(context).accentColor,
          child: new Center(
              child: new Text(
              _isCurrentBuild ? 'The current patch is too new. Show previous patch data?' : 'Showing previous build data',
              style: Theme.of(context).textTheme.body1,
          ))
        )
      );
    }
    return new Container(
      height: 0.1,
    );
  }
}