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
          color: Theme.of(context).errorColor,
          child: new Padding(
            padding: new EdgeInsets.only(left: 24.0),
            child: new Text(
              _isCurrentBuild ? 'This build doesn''t have enough recorded data to provide accurate data.' : 'Switch to the current build',
              style: Theme.of(context).textTheme.body1,
            )
          ),
            padding: new EdgeInsets.symmetric(horizontal: 8.0),
        )
      );
    }
    return new Container(
      height: 0.1,
    );
  }
}