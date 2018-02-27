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
    ThemeData theme = Theme.of(context);
    if (!_isCurrentBuild) {
      return new GestureDetector(
          onTap: onTap,
          child: new Container(
              constraints: new BoxConstraints.expand(height: 36.0),
              // Check if light or dark
              color: theme.primaryColor == Colors.deepPurple.shade500
                  ? theme.accentColor
                  : theme.hintColor,
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
