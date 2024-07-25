import 'package:flutter/material.dart';

import '../../../shared/constant/custom_color.dart';
import '../../../shared/constant/custom_textstyle.dart';

class TextOnlyButton extends StatelessWidget {
  final String buttonTitle;
  final void Function()? onPressed;
  final bool isMain;
  final double borderRadius;
  const TextOnlyButton(
      {super.key,
      required this.buttonTitle,
      required this.onPressed,
      required this.isMain,
      required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      color: isMain
          ? CustomColor.getSecondaryColor(context)
          : CustomColor.getPrimaryColor(context),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
          side: BorderSide(
              color: CustomColor.getSecondaryColor(context), width: 0.5)),
      onPressed: onPressed,
      child: Center(
        child: Text(
          buttonTitle,
          style: CustomTextStyle.getTitleStyle(
              context,
              15,
              isMain
                  ? CustomColor.getWhiteColor(context)
                  : CustomColor.getSecondaryColor(context)),
        ),
      ),
    );
  }
}
