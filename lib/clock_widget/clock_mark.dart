import 'dart:math';

import 'package:flutter/material.dart';

class ClockMark extends StatelessWidget {
  const ClockMark({
    @required this.clockSize,
    this.angle,
    this.height,
    this.width,
  });

  final double clockSize;
  final double angle;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: ((clockSize * .92) / 2) - (width / 2),
      child: Transform.rotate(
        angle: pi * angle,
        child: Container(
          height: clockSize * .92,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              mark(),
              mark(),
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
}
