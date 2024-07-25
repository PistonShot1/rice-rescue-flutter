import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';

import '../../../shared/constant/custom_color.dart';

class MyLineChart extends StatelessWidget {
  final List<FlSpot> listFlSpot;
  final bool isTemp;
  const MyLineChart(
      {super.key, required this.listFlSpot, required this.isTemp});

  @override
  Widget build(BuildContext context) {
    return buildLineChart(context);
  }

  Widget buildLineChart(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            verticalInterval: 1,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                  color: CustomColor.getSecondaryColor(context),
                  strokeWidth: 1);
            },
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: CustomColor.getSecondaryColor(context),
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 1,
                getTitlesWidget: bottomTitleWidgets,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: leftTitleWidgets,
                reservedSize: 42,
              ),
            ),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          minX: 0,
          maxX: 12,
          minY: 0,
          maxY: 6,
          lineBarsData: [
            LineChartBarData(
              spots: listFlSpot,
              isCurved: true, // Set this to true for curved line
              color: CustomColor.getSecondaryColor(context),
              barWidth: 2.0,
              dotData: FlDotData(show: true),
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

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('10:00', style: style);
        break;
      case 5:
        text = const Text('13:00', style: style);
        break;
      case 8:
        text = const Text('16:00', style: style);
        break;
      case 11:
        text = const Text('19:00', style: style);
        break;

      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = isTemp ? '10 C' : '10 %';
        break;

      case 3:
        text = isTemp ? '30 C' : '30 %';
        break;

      case 5:
        text = isTemp ? '50 C' : '50 %';
        break;

      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }
}
