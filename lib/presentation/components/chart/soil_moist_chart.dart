import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:vhack_client/features/field/domain/entity/field_entity.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';

import '../../../shared/constant/custom_color.dart';

class SoilMoistChart extends StatelessWidget {
  final FieldEntity fieldEntity;

  const SoilMoistChart({
    super.key,
    required this.fieldEntity,
  });

  double convertMoist(double value) {
    if (value > 100 || value == 100) {
      return 100 / 20;
    }
    return value / 20;
  }

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
              spots: [
                for (int i = 0;
                    i < fieldEntity.fieldSTEntity!.stPrev.length;
                    i++)
                  FlSpot(i.toDouble(),
                      convertMoist(fieldEntity.fieldSMEntity!.smPrev[i]))
              ],
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
        text = '20 %';
        break;

      case 3:
        text = '60 %';
        break;

      case 5:
        text = '100 %';
        break;

      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }
}
