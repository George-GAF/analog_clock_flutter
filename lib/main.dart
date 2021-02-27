import 'dart:async';
import 'dart:math';

import 'package:analog_clock/clock_widget/clock_mark.dart';
import 'package:flutter/material.dart';

import 'clock_widget/clock_wise.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isCalcSize = false;
  double secondPI;
  double minutePI;
  double hourPI;
  double second = 0;
  double minute = 0;
  double hour = 0;
  final repeatCount = 60;
  double value;

  @override
  void initState() {
    super.initState();
    value = 2 / repeatCount;
    second = (DateTime.now().second.toDouble());
    minute = (DateTime.now().minute.toDouble());
    hour = (DateTime.now().hour.toDouble());
    setState(() {
      secondPI = (second * value);
      minutePI = (minute * value);
      hourPI = (hour * (2 / 12));
    });
    runClock();
  }

  void runClock() {
    Duration duration = Duration(seconds: 1);
    Timer.periodic(duration, (timer) {
      if (second < 59) {
        ++second;
      } else {
        second = 0;
      }
      if (minute < 59) {
        minute += 1 / 59;
      } else {
        minute = 0;
      }
      if (second == 0) {
        hour += 1 / 59;
        if (minute == 0) {
          if (hour < 12) {
            ++hour;
          } else {
            hour = 0;
          }
        }
      }

      setState(() {
        secondPI = second * value;
        minutePI = minute * value;
        hourPI = hour * (2 / 12);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // print('build  $minute');

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final double selectedWidth = height > width ? width : height;
    final double clockSize = selectedWidth * .8;

    return Scaffold(
      backgroundColor: Color.fromRGBO(148, 148, 254, 1),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(
            clockSize * .01,
          ),
          height: clockSize,
          width: clockSize,
          child: Stack(
            children: [
              ClockMark(
                clockSize: clockSize,
                angle: 0,
                height: clockSize * .06,
                width: clockSize * .03,
              ),
              ClockMark(
                clockSize: clockSize,
                angle: .5,
                height: clockSize * .06,
                width: clockSize * .03,
              ),
              ClockMark(
                clockSize: clockSize,
                angle: .5 / 3,
                height: clockSize * .04,
                width: clockSize * .02,
              ),
              ClockMark(
                clockSize: clockSize,
                angle: (.5 / 3) * 2,
                height: clockSize * .04,
                width: clockSize * .02,
              ),
              ClockMark(
                clockSize: clockSize,
                angle: (1 / 6) * 4,
                height: clockSize * .04,
                width: clockSize * .02,
              ),
              ClockMark(
                clockSize: clockSize,
                angle: (1 / 6) * 5,
                height: clockSize * .04,
                width: clockSize * .02,
              ),

              //  Clockwise //
              Clockwise(
                left: (clockSize * .89) / 2,
                top: (clockSize * .23) / 2,
                angle: pi * hourPI,
                height: clockSize * .40,
                width: clockSize * .03,
                alignmentDirectional: AlignmentDirectional.bottomCenter,
                offset: Offset(0, -clockSize * .05),
              ),
              Clockwise(
                left: (clockSize * .90) / 2,
                top: (clockSize * .22) / 2,
                angle: pi * minutePI,
                height: clockSize * .45,
                width: clockSize * .02,
                alignmentDirectional: AlignmentDirectional.bottomCenter,
                offset: Offset(0, -clockSize * .10),
              ),
              Clockwise(
                left: (clockSize * .91) / 2,
                top: (clockSize * .12) / 2,
                angle: pi * secondPI,
                color: Colors.red[900],
                height: clockSize * .50,
                width: clockSize * .01,
                alignmentDirectional: AlignmentDirectional.bottomCenter,
                offset: Offset(0, -clockSize * .10),
              ),
              Positioned(
                left: (clockSize * .86) / 2,
                top: (clockSize * .86) / 2,
                child: Container(
                  width: clockSize * .06,
                  height: clockSize * .06,
                  decoration: BoxDecoration(
                      color: Colors.red[900],
                      borderRadius:
                          BorderRadius.circular((clockSize * .06) / 2)),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  offset: Offset(clockSize * .02, clockSize * .02),
                  blurRadius: 4)
            ],
            borderRadius: BorderRadius.circular((clockSize) / 2),
            border: Border.all(color: Colors.black87, width: clockSize * .03),
            color: Color.fromRGBO(250, 250, 250, 1),
          ),
        ),
      ),
    );
  }
}
