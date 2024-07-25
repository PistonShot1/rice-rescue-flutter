import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../shared/constant/custom_color.dart';
import '../../../shared/constant/custom_textstyle.dart';

class MyProgressBar extends StatelessWidget {
  final double radius, lineWidth, percentage;
  const MyProgressBar(
      {super.key,
      required this.radius,
      required this.lineWidth,
      required this.percentage});

  double _calculatePercentage(double percent) {
    return percent / 100;
  }

  @override
  Widget build(BuildContext context) {
    return buildProgressBar(context);
  }

  Widget buildProgressBar(BuildContext context) {
    return CircularPercentIndicator(
      percent: _calculatePercentage(percentage),
      radius: radius,
      lineWidth: lineWidth,
      animation: true,
      animateFromLastPercent: true,
      progressColor: selectColor(_calculatePercentage(percentage)),
      backgroundColor: CustomColor.getSecondaryColor(context).withOpacity(0.2),
      center: Text('${percentage.toInt()} %',
          style: CustomTextStyle.getTitleStyle(
              context, 21, CustomColor.getSecondaryColor(context))),
    );
  }

  Color _calculateColor1(double fillPercentage) {
    if (fillPercentage < 0.5) {
      return Color.lerp(Colors.red, Colors.green, fillPercentage * 2)!;
    } else {
      return Color.lerp(
          Colors.yellow, Colors.green, (fillPercentage - 0.5) * 2)!;
    }
  }

  Color selectColor(double fillPercentage) {
    if (fillPercentage <= 0.2) {
      return Colors.green;
    } else if (fillPercentage <= 0.4) {
      return Colors.yellow.shade700;
    } else if (fillPercentage <= 0.6) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  Color selectedColor(String phaseID, BuildContext context) {
    final Map<String, Color> phaseColor = {
      '1': Colors.black38,
      '2': Colors.orange,
      '3': Colors.yellow,
      '4': CustomColor.getSecondaryColor(context)
    };

    final Color? color = phaseColor[phaseID];
    if (color != null) {
      return color;
    }
    return Colors.black;
  }
}
