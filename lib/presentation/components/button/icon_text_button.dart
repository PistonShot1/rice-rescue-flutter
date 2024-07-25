import 'package:flutter/material.dart';

import '../../../shared/constant/custom_color.dart';
import '../../../shared/constant/custom_textstyle.dart';

class IconTextButton extends StatelessWidget {
  final String buttonTitle;
  final IconData buttonIcon;
  final void Function()? onPressed;
  const IconTextButton(
      {super.key,
      required this.buttonTitle,
      required this.buttonIcon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return buildButton(context);
  }

  Widget buildButton1(BuildContext context) {
    return TextButton.icon(
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(100, 50)),
            maximumSize: MaterialStateProperty.all(
                Size(MediaQuery.of(context).size.width, 50)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
            backgroundColor: MaterialStateProperty.all(
                CustomColor.getSecondaryColor(context))),
        onPressed: onPressed,
        icon: Icon(buttonIcon),
        label: Text(
          buttonTitle,
          style: CustomTextStyle.getTitleStyle(
              context, 15, CustomColor.getWhiteColor(context)),
        ));
  }

  Widget buildButton(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(vertical: 12),
      color: CustomColor.getPrimaryColor(context),
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          side: BorderSide(
              color: CustomColor.getSecondaryColor(context), width: 0.5)),
      onPressed: onPressed,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              buttonIcon,
              color: CustomColor.getSecondaryColor(context),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              buttonTitle,
              style: CustomTextStyle.getTitleStyle(
                  context, 15, CustomColor.getSecondaryColor(context)),
            ),
          ],
        ),
      ),
    );
  }
}
