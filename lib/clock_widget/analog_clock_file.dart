import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'clock_mark.dart';
import 'clock_wise.dart';

class AnalogClock extends StatefulWidget {
  final double clockSize;
  final bool showController;
  const AnalogClock({
    Key key,
    @required this.clockSize,
    this.showController,
  }) : super(key: key);

  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  bool isCalcSize = false;
  double secondPI;
  double minutePI;
  double hourPI;
  double second = 0;
  double minute = 0;
  double hour = 0;
  final repeatCount = 60;
  double value;
  double clockSize;

  bool showController;

  @override
  void initState() {
    super.initState();
    clockSize = widget.clockSize;
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
        minute += 1 / 60;
      } else {
        minute = 0;
      }
      if (second == 0) {
        print('hour change by on minute');
        hour += 1 / 60;
      }
      /*
      if (minute == 0) {
        print('hour change on hour');
        if (hour < 11) {
          ++hour;
        } else {
          hour = 0;
        }
      }
*/
      setState(() {
        secondPI = second * value;
        minutePI = minute * value;
        hourPI = hour * (2 / 12);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    showController = widget.showController;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(
            clockSize * .01,
          ),
          height: clockSize,
          width: clockSize,
          child: Stack(
            children: [
              for (int i = 0; i < 30; i++)
                ClockMark(
                  clockSize: clockSize,
                  angle: (1 / 30) * i,
                  height: clockSize *
                      (i == 0 || i == 15
                          ? .06
                          : i % 5 == 0
                              ? .04
                              : .02),
                  width: clockSize *
                      (i == 0 || i == 15
                          ? .03
                          : i % 5 == 0
                              ? .02
                              : .01),
                  isNumber: false,
                ),
              for (int i = 1; i <= 6; i++)
                ClockMark(
                  clockSize: clockSize,
                  angle: (1 / 6) * i,
                  height: clockSize * .1,
                  width: clockSize * .1,
                  isNumber: true,
                  number: '$i',
                  number1: '${i + 6}',
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
        showController
            ? Container(
                margin: EdgeInsets.only(
                    left: clockSize * .03, top: clockSize * .85),
                width: clockSize * .94,
                child: Row(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ChangeButton(
                      icon: Icons.add,
                      onClick: () {
                        setState(() {
                          clockSize *= 1.05;
                        });
                      },
                      size: clockSize * .1,
                    ),
                    ChangeButton(
                      icon: Icons.remove,
                      onClick: () {
                        setState(() {
                          clockSize *= .95;
                        });
                      },
                      size: clockSize * .1,
                    ),
                  ],
                ),
              )
            : SizedBox(),
      ],
    );
  }
}

class ChangeButton extends StatelessWidget {
  final IconData icon;
  final Function onClick;
  final double size;

  const ChangeButton({Key key, this.icon, this.onClick, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: size,
        height: size,
        child: Icon(
          icon,
          size: size * .9,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2),
          color: Colors.blue[900],
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 5,
              offset: Offset(2, 2),
            )
          ],
        ),
      ),
    );
  }
}
