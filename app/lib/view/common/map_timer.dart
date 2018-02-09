import 'dart:async';

import 'package:flutter/material.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';

class MapTimer extends StatefulWidget {
  final PlayableMap map;

  MapTimer(this.map, {key}) : super(key: key);

  @override
  State createState() => new _MapTimerState();
}

class _MapTimerState extends State<MapTimer> {
  String buttonText = 'Start Timer';
  bool hasGameStarted = false;
  /// Ranges between 0.0 and 1.0
  double percentageComplete = 0.0;
  int callCount = 0;
  int timerLength = 0;

  Timer timer;
  void manageTimer() {
    if (timer == null || !timer.isActive) {
      int length = hasGameStarted ? widget.map.objective_interval : widget.map.objective_start_time;
      setState(() {
        buttonText = 'Cancel Timer';
        percentageComplete = 0.0;
        timerLength = length;
        timer = new Timer.periodic(
          new Duration(seconds: length),
          (Timer timer) => adjustPercentage(timer)
        );
        hasGameStarted = true;
      });
    } else {
      timer.cancel();
      setState(() {
        buttonText = 'Start Timer';
      });
    }
  }

  void adjustPercentage(Timer timer) {
    double newPercentage = callCount / timerLength;
    setState(() {
      percentageComplete = newPercentage;
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return new Stack(
      children: <Widget>[
        new Column(
          children: <Widget>[
             new FlatButton(
              onPressed: () => manageTimer(),
              child: new Text(buttonText),
            ),
            new Text('${(timerLength - callCount).toString()} Remaining')
          ],
        ),
        new Column(children: <Widget>[
          new Container(
            
            height: deviceHeight * (1.0 - percentageComplete),
          ),
          new Container(
            height: deviceHeight * percentageComplete,
          )
        ],)
      ],
    );
  }
}