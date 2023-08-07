import 'dart:async';

import 'package:flutter/material.dart';

class ShowCallTimer extends StatefulWidget {

  @override
  ShowCallTimerState createState() => ShowCallTimerState();
}

class ShowCallTimerState extends State<ShowCallTimer> {

  Stopwatch watch = Stopwatch();
  Timer? timer;
  String elapsedTime = '00:00:00';

  updateTime(Timer timer) {
    if (watch.isRunning) {
      setState(() {
        elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    startWatch();
  }
  @override
  Widget build(BuildContext context) {
    return Text(elapsedTime, style: TextStyle(fontSize: 14));
  }

  startWatch() {
    setState(() {
      watch.start();
      timer = Timer.periodic(Duration(milliseconds: 100), updateTime);
    });
  }

  setTime() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
    });
  }

  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr:$secondsStr";
  }
}
