import 'dart:math';

import 'package:flutter/material.dart';

class ClockMark extends StatelessWidget {
  const ClockMark({
    @required this.clockSize,
    @required this.angle,
    @required this.height,
    @required this.width,
    @required this.isNumber,
    this.number,
    this.number1,
  });

  final double clockSize;
  final double angle;
  final double height;
  final double width;
  final bool isNumber;
  final String number;
  final String number1;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: ((clockSize * .92) / 2) - (width / 2),
      top: isNumber ? clockSize * .06 : 0,
      child: Transform.rotate(
        angle: pi * angle,
        child: Container(
          height: clockSize * (isNumber ? 0.79 : 0.92),
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              !isNumber ? mark() : numberW(number),
              !isNumber ? mark() : numberW(number1),
            ],
          ),
        ),
      ),
    );
  }

  Widget mark() {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(width / 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 3,
            offset: Offset(-1, -1),
          )
        ],
      ),
    );
  }

  Widget numberW(String number) {
    return Transform.rotate(
      angle: pi * -angle,
      child: Text(
        number,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: width * .8,
          fontWeight: FontWeight.bold,
          shadows: [
            BoxShadow(
              offset: Offset(1, 1),
              color: Colors.black,
              blurRadius: 3,
            ),
          ],
        ),
      ),
    );
  }
}
