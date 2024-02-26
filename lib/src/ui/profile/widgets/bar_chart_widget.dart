import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class BarChartWidget extends StatefulWidget {
  const BarChartWidget({super.key});

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
 ScrollDragController? controller;
 late double minX;
 late double maxX;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    minX = 0;
    maxX = BarData.barData.length.toDouble();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.all(10),
      decoration:  BoxDecoration(
        color: AppColors.primaryWhiteColor,
        boxShadow: const [
          BoxShadow(
            color: AppColors.boxShadow,
            blurRadius: 4,
            offset: Offset(4, 2),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: AppColors.boxShadow,
            blurRadius: 4,
            offset: Offset(-4, -2),
            spreadRadius: 0,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ZoomableChart(
          maxX: 5,
          builder: (minX, maxX) {
            return BarChart(
              swapAnimationDuration: const Duration(milliseconds: 150), // Optional
              swapAnimationCurve: Curves.linear,
              BarChartData(
                  maxY: 20,
                  gridData:  FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    drawHorizontalLine: true,
                    checkToShowHorizontalLine: (value) => value % BarData.interval == 0,
                  ),
                  alignment: BarChartAlignment.spaceAround,
                  borderData: FlBorderData(
                      border: const Border(bottom: BorderSide(
                        color: AppColors.chartAxisLineColors,
                        width: 2,
                      ), left: BorderSide(
                        color: AppColors.chartAxisLineColors,
                        width: 2,
                      ),
                      )
                  ),
                  groupsSpace: 10,
                  barTouchData: BarTouchData(
                    allowTouchBarBackDraw: true,
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.grey,
                      getTooltipItem: (a, b, c, d) => null,
                    ),
                  ),
                  // baselineY: 0,
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(sideTitles: BarTitle.getBottomTitles()),
                    leftTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    // leftTitles: BarTitle.getLeftTitle(),
                  ),
                  // borderData: ,
                  barGroups: BarData.barData
                      .map(
                        (data) =>
                        BarChartGroupData(
                          barsSpace: 3,
                          groupVertically: true,
                          x: data.id,
                          barRods: [
                            BarChartRodData(
                              toY: data.y,
                              width: 10,
                              color: data.y <= 5 ? AppColors.secondaryColor : AppColors.primaryColor,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(5),
                                topLeft: Radius.circular(5),
                              ),
                            ),
                          ],
                        ),
                  )
                      .toList()),
            );
          },
        ),
      ),
    );

  }
}

class BarTitle {
  static SideTitles getBottomTitles() {
    return SideTitles(
      showTitles: true,
      getTitlesWidget: (value, meta) {
        String text = '';
        switch (value.toInt()) {
          case 0:
            text = 'Jan';
            break;
          case 2:
            text = 'Feb';
            break;
          case 4:
            text = 'Mar';
            break;
          case 6:
            text = 'Apr';
            break;
          case 8:
            text = 'May';
            break;
          case 10:
            text = 'Jun';
            break;
          case 11:
            text = 'Jul';
            break;
          case 12:
            text = 'Aug';
            break;
          case 13:
            text = 'Sep';
            break;
          case 14:
            text = 'Oct';
            break;
          case 15:
            text = 'Nov';
            break;
          case 16:
            text = 'Dec';
            break;
        }

        return Text(text);
      },
    );
  }
}

class Data {
  final int id;
  final String name;
  final double y;
  // final Color color;

  const Data(
      {required this.id,
      required this.name,
      required this.y,
      // required this.color
      });
}

class BarData {
  static int interval = 4;

  static List<Data> barData = [
    const Data(
      id: 0,
      name: 'Mon',
      y: 15,
      // color: Color(0xff19bfff),
    ),
    const Data(
      name: 'Tue',
      id: 1,
      y: 12,
      // color: Color(0xffff4d94),
    ),
    const Data(
      name: 'Wed',
      id: 2,
      y: 11,
      // color: Color(0xff2bdb90),
    ),
    const Data(
      name: 'Thu',
      id: 3,
      y: 10,
      // color: Color(0xffffdd80),
    ),
    const Data(
      name: 'Fri',
      id: 4,
      y: 5,
      // color: Color(0xff2bdb90),
    ),
    const Data(
      name: 'Sat',
      id: 5,
      y: 17,
      // color: Color(0xffffdd80),
    ),
    const Data(
      name: 'Sun',
      id: 6,
      y: 5,
      // color: Color(0xffff4d94),
    ),
    const Data(
      id: 7,
      name: 'Mon',
      y: 15,
      // color: Color(0xff19bfff),
    ),
    const Data(
      id: 8,
      name: 'Mon',
      y: 15,
      // color: Color(0xff19bfff),
    ),
    const Data(
      id: 9,
      name: 'Mon',
      y: 15,
      // color: Color(0xff19bfff),
    ),
    const Data(
      id: 10,
      name: 'Mon',
      y: 15,
      // color: Color(0xff19bfff),
    ),
    const Data(
      id: 11,
      name: 'Mon',
      y: 15,
      // color: Color(0xff19bfff),
    ),
    const Data(
      id: 12,
      name: 'Mon',
      y: 15,
      // color: Color(0xff19bfff),
    ),
    const Data(
      id: 13,
      name: 'Mon',
      y: 15,
      // color: Color(0xff19bfff),
    ),

  ];
}


class ZoomableChart extends StatefulWidget {
  ZoomableChart({
    super.key,
    required this.maxX,
    required this.builder,
  });

  double maxX;
  Widget Function(double, double) builder;

  @override
  State<ZoomableChart> createState() => _ZoomableChartState();
}

class _ZoomableChartState extends State<ZoomableChart> {
  late double minX;
  late double maxX;

  late double lastMaxXValue;
  late double lastMinXValue;

  @override
  void initState() {
    super.initState();
    minX = 0;
    maxX = widget.maxX;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          minX = 0;
          maxX = widget.maxX;
        });
      },
      onHorizontalDragStart: (details) {
        lastMinXValue = minX;
        lastMaxXValue = maxX;
      },
      onHorizontalDragUpdate: (details) {
        var horizontalDistance = details.primaryDelta ?? 0;
        if (horizontalDistance == 0) return;
        print(horizontalDistance);
        var lastMinMaxDistance = max(lastMaxXValue - lastMinXValue, 0.0);

        setState(() {
          minX -= lastMinMaxDistance * 0.005 * horizontalDistance;
          maxX -= lastMinMaxDistance * 0.005 * horizontalDistance;

          if (minX < 0) {
            minX = 0;
            maxX = lastMinMaxDistance;
          }
          if (maxX > widget.maxX) {
            maxX = widget.maxX;
            minX = maxX - lastMinMaxDistance;
          }
          print("$minX, $maxX");
        });
      },
      onScaleStart: (details) {
        lastMinXValue = minX;
        lastMaxXValue = maxX;
      },
      onScaleUpdate: (details) {
        var horizontalScale = details.horizontalScale;
        if (horizontalScale == 0) return;
        print(horizontalScale);
        var lastMinMaxDistance = max(lastMaxXValue - lastMinXValue, 0);
        var newMinMaxDistance = max(lastMinMaxDistance / horizontalScale, 10);
        var distanceDifference = newMinMaxDistance - lastMinMaxDistance;
        print("$lastMinMaxDistance, $newMinMaxDistance, $distanceDifference");
        setState(() {
          final newMinX = max(
            lastMinXValue - distanceDifference,
            0.0,
          );
          final newMaxX = min(
            lastMaxXValue + distanceDifference,
            widget.maxX,
          );

          if (newMaxX - newMinX > 2) {
            minX = newMinX;
            maxX = newMaxX;
          }
          print("$minX, $maxX");
        });
      },
      child: widget.builder(minX, maxX),
    );
  }
}