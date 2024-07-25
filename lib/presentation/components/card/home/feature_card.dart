import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/constant/custom_color.dart';
import '../../../../shared/constant/custom_textstyle.dart';

class FeatureCard extends StatelessWidget {
  final eachFeature;
  final void Function()? onPressed;
  const FeatureCard(
      {super.key, required this.eachFeature, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                blurRadius: 5,
                color: Color(0x3F14181B),
                offset: Offset(0, 3),
              )
            ],
            borderRadius: BorderRadius.circular(12),
            color: CustomColor.getPrimaryColor(context)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              eachFeature['featureIcon'],
              semanticsLabel: 'Acme Logo',
              height: 40,
              width: 40,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              eachFeature['featureTitle'],
              style: CustomTextStyle.getTitleStyle(
                  context, 10, CustomColor.getTertieryColor(context)),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
