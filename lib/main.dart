import 'package:flutter/material.dart';

import 'clock_widget/analog_clock_file.dart';

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
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  double _x = 0;
  double _y = 0;
  bool showController = true;
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final double selectedWidth = height > width ? width : height;
    final double clockSize = selectedWidth * .8;

    return Scaffold(
      backgroundColor: Color.fromRGBO(148, 148, 254, 1),
      body: Stack(
        children: [
          Positioned(
            top: _y,
            left: _x,
            child: GestureDetector(
              onPanStart: (de) {
                setState(() {
                  showController = false;
                  _x = de.localPosition.dx - (clockSize / 2);
                  _y = de.localPosition.dy;
                });
                print('$de');
              },
              onPanUpdate: (de) {
                setState(() {
                  _x = de.localPosition.dx - (clockSize / 2);
                  _y = de.localPosition.dy;
                });
              },
              onPanEnd: (_) {
                setState(() {
                  showController = true;
                });
              },
              child: AnalogClock(
                clockSize: clockSize,
                showController: showController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
