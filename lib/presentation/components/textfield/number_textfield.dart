import 'package:flutter/material.dart';

import '../../../shared/constant/custom_color.dart';
import '../../../shared/constant/custom_textstyle.dart';

class NumberTextField extends StatelessWidget {
  final TextEditingController tcInput;
  final String tcTitle;
  final IconData tcIcon;
  const NumberTextField(
      {super.key,
      required this.tcInput,
      required this.tcTitle,
      required this.tcIcon});

  @override
  Widget build(BuildContext context) {
    return buildInputTextField(context);
  }

  Widget buildInputTextField(BuildContext context) {
    return TextField(
      controller: tcInput,
      keyboardType: TextInputType.number,
      cursorColor: CustomColor.getSecondaryColor(context),
      style: CustomTextStyle.getTitleStyle(
          context, 15, CustomColor.getTertieryColor(context)),
      decoration: InputDecoration(
          hintText: tcTitle,
          hintStyle: CustomTextStyle.getSubTitleStyle(context, 15, Colors.grey),
          prefixIcon: Icon(
            tcIcon,
            color: CustomColor.getSecondaryColor(context),
          ),
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: CustomColor.getSecondaryColor(context), width: 2))),
    );
  }
}
