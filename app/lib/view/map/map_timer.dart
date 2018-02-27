import 'dart:async';

import 'package:flutter/material.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';

class MapTimer extends StatefulWidget {
  final PlayableMap map;

  MapTimer(this.map, {key}) : super(key: key);

  @override
  State createState() => new _MapTimerState();
}

// TODO Make screen stay on
class _MapTimerState extends State<MapTimer> {
  String buttonText = 'Start Timer';
  bool hasGameStarted = false;

  /// Ranges between 0 and 100
  double percentageComplete = 0.0;
  double callCount = 0.0;
  int timerLength = 0;

  @override
  void dispose() {
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }

  Timer timer;
  void manageTimer() {
    if (timer == null || !timer.isActive) {
      int length = hasGameStarted
          ? widget.map.objective_interval
          : widget.map.objective_start_time;
      setState(() {
        timerLength = length;
        buttonText = 'Cancel Timer';
        timer = new Timer.periodic(new Duration(milliseconds: 100),
            (Timer timer) => adjustPercentage(timer));
        hasGameStarted = true;
      });
    } else {
      timer.cancel();
      resetState();
    }
  }

  void resetState() {
    setState(() {
      percentageComplete = 0.0;
      callCount = 0.0;
      buttonText = 'Start Timer';
    });
  }

  void adjustPercentage(Timer timer) {
    if (!this.mounted) {
      timer.cancel();
      return;
    }
    double newPercentage = ((callCount / timerLength) * 100);
    setState(() {
      percentageComplete = newPercentage;
      callCount = callCount + 0.1;
    });
    if (callCount >= timerLength) {
      timer.cancel();
      // TODO make noise
      //TODO set timeout then reset state to achieve orange flash
      resetState();
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData query = MediaQuery.of(context);
    ThemeData theme = Theme.of(context);
    double deviceHeight =
        ((query.size.height - query.padding.top - query.padding.bottom) / 100);
    return new Card(
        color: theme.primaryColor,
        child: new Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Container(
                  color: theme.primaryColor,
                  height:
                      (deviceHeight * (100 - percentageComplete)).toDouble(),
                ),
                new Container(
                  color: theme.accentColor,
                  height: (deviceHeight * percentageComplete).toDouble(),
                )
              ],
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new FlatButton(
                  color: Colors.white,
                  onPressed: () => manageTimer(),
                  child: new Padding(
                      padding: new EdgeInsets.all(24.0),
                      child: new Text(
                        buttonText.toUpperCase(),
                      )),
                ),
                new Container(
                  height: query.size.height * 0.05,
                ),
                _buildSupportingText(context)
              ],
            ),
            (timer == null || !timer.isActive)
                ? new Padding(
                    padding: new EdgeInsets.all(4.0)
                        .add(new EdgeInsets.only(bottom: 8.0)),
                    child: new Text(
                      widget.map.name.toUpperCase(),
                      style: Theme
                          .of(context)
                          .textTheme
                          .title
                          .apply(color: Colors.white, fontSizeFactor: 1.1),
                    ))
                : new Container()
          ],
        ));
  }

  Widget _buildSupportingText(BuildContext context) {
    // Display seconds remaining
    TextStyle style = Theme.of(context).textTheme.title.apply(
          color: Colors.white,
          fontSizeFactor: 1.1,
        );
    if (timer != null && timer.isActive) {
      return new Text(
        '${(timerLength - callCount).toStringAsFixed(0)} Seconds Remaining Until ${widget.map.objective_name}',
        style: style,
      );
    } else if (hasGameStarted) {
      return new Text(
        'Press ${widget.map.objective_finish_prompt}',
        style: style,
      );
      // When the objective is complete prompt
    } else {
      return new Text(
        'Press when the game begins',
        style: style,
      );
      // Press when game starts prompt
    }
  }
}
