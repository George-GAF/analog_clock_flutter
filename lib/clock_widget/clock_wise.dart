import 'package:flutter/material.dart';

class Clockwise extends StatelessWidget {
  final double width;
  final double height;
  final double top;
  final double left;
  final double angle;
  final Color color;
  final AlignmentDirectional alignmentDirectional;
  final Offset offset;

  const Clockwise(
      {this.width,
      this.height,
      this.top,
      this.left,
      this.angle,
      this.alignmentDirectional,
      this.offset,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: Transform.rotate(
        angle: angle,
        alignment: alignmentDirectional ?? AlignmentDirectional.center,
        origin: offset ?? Offset(0, 0),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 3,
                  offset: Offset(-1, -1),
                )
              ],
              color: color ?? Colors.black87,
              borderRadius: BorderRadius.circular(width / 2)),
        ),
      ),
    );
  }
}
