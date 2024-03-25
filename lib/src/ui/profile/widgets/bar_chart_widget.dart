import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_collect/src/bloc/purchase_history_bloc/purchase_history_bloc.dart';

import '../../../constants/colors.dart';
import '../../../model/purchase_history/purchase_history_response.dart';

class BarChartWidget extends StatefulWidget {
  const BarChartWidget({super.key});

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
 ScrollDragController? controller;
 late double minX;
 late double maxX;
 late  String totalAmount = "0";


 // List<PurchaseData>? purchaseData;





 void checkSameDate(PurchaseHistoryResponse jsonData) {
   for (int i = 0; i < jsonData.data!.length; i++) {
     String currentDate = jsonData.data![i].receiptDate.toString();
     for (int j = i + 1; j < jsonData.data!.length; j++) {
       if (currentDate == jsonData.data![j].receiptDate) {

         // totalAmount = (jsonData.data![i].totalAmount! + jsonData.data![j].totalAmount!);
         // print("Date ${jsonData.data![j].receiptDate} found at indexes $i and $j");
         // print("Total amount: $totalAmount of indexes $i and $j");
         // You can do further processing here if needed
       }
     }
   }
 }


 @override
  void initState() {
    super.initState();
    minX = 0;
  }
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<PurchaseHistoryBloc, PurchaseHistoryState>(
  listener: (context, state) {
    if(state is PurchaseHistoryLoaded) {
     // purchaseData = state.purchaseHistoryResponse.data;
    }
  },
  builder: (context, state) {
   if(state is PurchaseHistoryLoaded) {
     if(state.purchaseHistoryResponse.data!.isNotEmpty) {
       return AspectRatio(
         aspectRatio: 16 / 9,
         child: BarChart(
           swapAnimationDuration: const Duration(milliseconds: 150), // Optional
           swapAnimationCurve: Curves.linear,
           BarChartData(
               maxY: _getMaxTotalAmount(state.purchaseHistoryResponse),
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
               barGroups: _buildBarGroups(state.purchaseHistoryResponse),
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


double _getMaxTotalAmount(PurchaseHistoryResponse purchaseData) {
  double maxTotalAmount = 0;
  for (var data in purchaseData.data!) {
    double amount = double.tryParse(data.totalAmount!) ?? 0;
    if (amount > maxTotalAmount) {
      maxTotalAmount = amount;
    }
  }
  return maxTotalAmount;
}

List<BarChartGroupData> _buildBarGroups(PurchaseHistoryResponse purchaseData) {
  List<BarChartGroupData> barGroups = [];

  Map<String, List<PurchaseData>> groupedData = {};

  final List<Color> rodColors = [
 AppColors.secondaryColor,
    AppColors.primaryColor,
  ];

  // Group data by receipt_date
  for (var data in purchaseData.data!) {
    groupedData.putIfAbsent(data.receiptDate!, () => []);
    groupedData[data.receiptDate!]!.add(data);
  }

  // Create BarChartGroupData for each receipt_date
  groupedData.forEach((receiptDate, items) {
    double totalAmount = 0;
    List<BarChartRodData> rods = [];
    for (int i = 0; i < items.length; i++) {
      double amount = double.tryParse(items[i].totalAmount!) ?? 0;
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

        return Text(text);
      },
    );
  }
}
