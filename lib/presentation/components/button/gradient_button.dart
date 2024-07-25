import 'package:flutter/material.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';

class GradientButton extends StatelessWidget {
  final String buttonTitle;
  final void Function()? onPressed;
  const GradientButton(
      {super.key, required this.buttonTitle, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 52,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                CustomColor.getSecondaryColor(
                  context,
                ),
                CustomColor.getPrimaryColor(context)
              ],
              stops: const [
                0,
                1
              ],
              begin: AlignmentDirectional(0, -1),
              end: AlignmentDirectional(0, 1)),
          borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Text(
            buttonTitle,
            style: CustomTextStyle.getTitleStyle(
                context, 15, CustomColor.getWhiteColor(context)),
          ),
        ),
      ),
    );
  }
}
