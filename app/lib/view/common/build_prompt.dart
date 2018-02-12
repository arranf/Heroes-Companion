import 'package:flutter/scheduler.dart';
import 'package:flutter/material.dart';

class BuildPrompt extends StatelessWidget {
  final bool _isCurrentBuild;
  final dynamic onTap;
  final String patchName;

  BuildPrompt(
    this._isCurrentBuild,
    this.patchName,
    this.onTap, {
    key,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!_isCurrentBuild) {
      return new GestureDetector(
          onTap: onTap,
          child: new Container(
              constraints: new BoxConstraints.expand(height: 36.0),
              color: _isCurrentBuild
                  ? Theme.of(context).errorColor
                  : Theme.of(context).accentColor,
              child: new Center(
                  child: new Text(
                'Showing previous patch data ($patchName)'.toUpperCase(),
                maxLines: 2,
                style: Theme
                    .of(context)
                    .textTheme
                    .body1
                    .copyWith(
                      fontWeight: FontWeight.w500,
                    )
                    .apply(fontSizeFactor: 0.9),
              ))));
    }
    return new Container();
  }
}
