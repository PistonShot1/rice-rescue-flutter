import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../../shared/constant/custom_color.dart';
import '../../../shared/constant/custom_textstyle.dart';

class CustomSlider extends StatelessWidget {
  final double percentage;
  final double lineWidth;
  final double radius;
  const CustomSlider(
      {super.key,
      required this.percentage,
      required this.lineWidth,
      required this.radius});

  double convertPercentage(double value) {
    return value / 100;
  }

  @override
  Widget build(BuildContext context) {
    return buildProgressBar(context);
  }

  Color _calculateColor(double fillPercentage) {
    if (fillPercentage < 0.5) {
      return Color.lerp(Colors.red, Colors.green, fillPercentage * 2)!;
    } else {
      return Color.lerp(
          Colors.yellow, Colors.green, (fillPercentage - 0.5) * 2)!;
    }
  }

  Color selectColor(double fillPercentage) {
    if (fillPercentage <= 0.25) {
      return Colors.green;
    } else if (fillPercentage <= 0.50) {
      return const Color.fromARGB(255, 251, 230, 45);
    } else if (fillPercentage <= 0.75) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  Widget buildProgressBar(BuildContext context) {
    return CircularPercentIndicator(
      percent: convertPercentage(percentage),
      radius: radius,
      lineWidth: lineWidth,
      animation: true,
      animateFromLastPercent: true,
      progressColor: selectColor(convertPercentage(percentage)),
      backgroundColor: CustomColor.getSecondaryColor(context).withOpacity(0.2),
      center: Text('${percentage.toInt()} %',
          style: CustomTextStyle.getTitleStyle(
              context, 21, CustomColor.getSecondaryColor(context))),
    );
  }

  Widget buildCircularProgress(BuildContext context) {
    return CircularPercentIndicator(
      radius: radius,
      lineWidth: lineWidth,
      percent: percentage / 100,
      center: Text(
        percentage.toStringAsFixed(2),
        style: CustomTextStyle.getTitleStyle(
            context, 15, CustomColor.getTertieryColor(context)),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: _calculateColor(percentage / 100),
      backgroundColor: Color.fromRGBO(77, 131, 112, 1),
    );
  }
}
