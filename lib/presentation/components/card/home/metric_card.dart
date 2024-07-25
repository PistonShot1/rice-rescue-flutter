import 'package:flutter/material.dart';

import '../../../../shared/constant/custom_color.dart';
import '../../../../shared/constant/custom_textstyle.dart';

class MetricCard extends StatelessWidget {
  final eachMetric;
  const MetricCard({super.key, required this.eachMetric});

  @override
  Widget build(BuildContext context) {
    return buildWidgetMetric(context, eachMetric['metricTitle'],
        eachMetric['metricWidget'], eachMetric['metricDesc']);
  }

  Widget buildWidgetMetric(BuildContext context, String metricTitle,
      Widget metricWidget, String metricDesc) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              blurRadius: 2,
              color: Color(0x3F14181B),
              offset: Offset(0, 3),
            )
          ],
          borderRadius: BorderRadius.circular(16),
          color: CustomColor.getPrimaryColor(context)),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(metricTitle,
                style: CustomTextStyle.getSubTitleStyle(
                  context,
                  15,
                  CustomColor.getTertieryColor(context),
                )),
          ],
        ),
        Expanded(child: metricWidget),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              metricDesc,
              style: CustomTextStyle.getTitleStyle(
                  context, 12, CustomColor.getTertieryColor(context)),
            ),
          ],
        )
      ]),
    );
  }
}
