import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_collect/src/bloc/point_tracker_bloc/point_tracker_bloc.dart';

import '../../../constants/colors.dart';
import '../../../model/point_tracker/point_tracker_response.dart';

class PointTrackerChart extends StatefulWidget {
  const PointTrackerChart({super.key});

  @override
  State<PointTrackerChart> createState() => _PointTrackerChartState();
}

class _PointTrackerChartState extends State<PointTrackerChart> {
  ScrollDragController? controller;
  late double minX;
  late double maxX;
  late  String totalAmount = "0";


  // List<PurchaseData>? purchaseData;



  @override
  void initState() {
    super.initState();
    minX = 0;
  }
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<PointTrackerBloc, PointTrackerState>(
      listener: (context, state) {
        if(state is PointTrackerLoaded) {
          // purchaseData = state.purchaseHistoryResponse.data;
        }
      },
      builder: (context, state) {
        if(state is PointTrackerLoaded) {
          if(state.pointTrackerRequestResponse.data.isNotEmpty) {
            return AspectRatio(
              aspectRatio: 16 / 9,
              child: BarChart(
                swapAnimationDuration: const Duration(milliseconds: 150), // Optional
                swapAnimationCurve: Curves.linear,
                BarChartData(
                  maxY: _getMaxTotalAmount(state.pointTrackerRequestResponse),
                  gridData:  const FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    drawHorizontalLine: true,
                    // checkToShowHorizontalLine: (value) => value % BarData.interval == 0,
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
                  // groupsSpace: 4,
                  barTouchData: BarTouchData(
                    allowTouchBarBackDraw: true,
                    enabled: true,
                  ),
                  // baselineY: 0,
                  titlesData:  const FlTitlesData(
                    bottomTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    // AxisTitles(sideTitles: BarTitle.getBottomTitles()),
                    leftTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: true),
                    ),
                    topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    // leftTitles: BarTitle.getLeftTitle(),
                  ),
                  // borderData: ,
                  barGroups: _buildBarGroups(state.pointTrackerRequestResponse),
                ),
              ),
            );
          }
        }
        return const SizedBox();
      },
    );

  }
}


double _getMaxTotalAmount(PointTrackerRequestResponse pointTrackerData) {
  double maxTotalAmount = 0;
  for (var data in pointTrackerData.data) {
    double amount = double.tryParse(data.totalPoints.toString()) ?? 0;
    if (amount > maxTotalAmount) {
      maxTotalAmount = amount;
    }
  }
  return maxTotalAmount;
}

List<BarChartGroupData> _buildBarGroups(PointTrackerRequestResponse pointTrackerData) {
  List<BarChartGroupData> barGroups = [];

  Map<String, List<PointTrackerData>> groupedData = {};

  final List<Color> rodColors = [
    AppColors.secondaryColor,
    AppColors.primaryColor,
  ];

  // Group data by receipt_date
  for (var data in pointTrackerData.data) {
    groupedData.putIfAbsent(data.totalPoints.toString(), () => []);
    groupedData[data.totalPoints.toString()]!.add(data);
  }

  // Create BarChartGroupData for each receipt_date
  groupedData.forEach((receiptDate, items) {
    double totalAmount = 0;
    List<BarChartRodData> rods = [];
    for (int i = 0; i < items.length; i++) {
      double amount = double.tryParse(items[i].totalPoints.toString()) ?? 0;
      totalAmount += amount;
      rods.add(
        BarChartRodData(
          fromY: 0,
          toY: amount,
          color: rodColors[i % rodColors.length],
        ),
      );
    }
    // for (var item in items)
    // {
    //
    //   double amount = double.tryParse(item.totalAmount!) ?? 0;
    //   totalAmount += amount;
    //   rods.add(
    //     BarChartRodData(
    //       toY: amount,
    //       color: rodColors[i % rodColors.length],
    //     ),
    //   );
    // }
    barGroups.add(
      BarChartGroupData(
        x: barGroups.length,
        barsSpace: 1,
        barRods: rods,
        // showingTooltipIndicators: List.generate(rods.length, (index) => index),
      ),
    );
  });

  return barGroups;
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

        return Text(text,);
      },
    );
  }
}
