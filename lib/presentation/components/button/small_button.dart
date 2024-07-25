import 'package:flutter/material.dart';

import '../../../shared/constant/custom_color.dart';
import '../../../shared/constant/custom_textstyle.dart';

class SmallButton extends StatelessWidget {
  final String buttonTitle;
  final void Function()? onPressed;
  const SmallButton(
      {super.key, required this.buttonTitle, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return buildSmallButton(context);
  }

  Widget buildSmallButton(BuildContext context) {
    return MaterialButton(
      color: CustomColor.getBackgroundColor(context),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Colors.grey, width: 0.5)),
      onPressed: onPressed,
      child: Text(
        buttonTitle,
        style: CustomTextStyle.getTitleStyle(
            context, 12, CustomColor.getSecondaryColor(context)),
      ),
    );
  }
}
