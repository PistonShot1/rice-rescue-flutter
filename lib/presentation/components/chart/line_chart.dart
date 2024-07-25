import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({Key? key}) : super(key: key);

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 200,
      padding: EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 0.2),
                FlSpot(1, 0.21),
                FlSpot(2, 0.39),
                FlSpot(3, 0.3),
                FlSpot(4, 0.1),
              ],
              isCurved: true, // Set this to true for curved line
              color: CustomColor.getSecondaryColor(context),
              barWidth: 2.0,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: CustomColor.getSecondaryColor(context)
                    .withOpacity(0.3), // Set background color
              ),
            ),
          ],
        ),
        swapAnimationCurve: Curves.bounceOut,
      ),
    );
  }
}
