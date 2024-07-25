import 'package:flutter/material.dart';

import '../../../shared/constant/custom_color.dart';

class IconOnlyButton extends StatelessWidget {
  final IconData iconData;
  final void Function()? onPressed;
  final double borderRadius;
  const IconOnlyButton(
      {super.key,
      required this.iconData,
      required this.onPressed,
      required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return buildIconOnlyButton(context);
  }

  Widget buildIconOnlyButton(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: CustomColor.getSecondaryColor(context))),
        child: Icon(
          iconData,
          size: 25.0,
          color: Colors.black,
        ),
      ),
    );
  }
}
