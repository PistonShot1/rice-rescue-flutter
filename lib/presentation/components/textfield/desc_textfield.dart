import 'package:flutter/material.dart';

import '../../../shared/constant/custom_color.dart';
import '../../../shared/constant/custom_textstyle.dart';

class DescTextField extends StatelessWidget {
  final TextEditingController tcDesc;
  final String descTitle;
  const DescTextField(
      {super.key, required this.tcDesc, required this.descTitle});

  @override
  Widget build(BuildContext context) {
    return buildDescTextField(context);
  }

  Widget buildDescTextField(BuildContext context) {
    return TextField(
      controller: tcDesc,
      keyboardType: TextInputType.text,
      cursorColor: CustomColor.getSecondaryColor(context),
      style: CustomTextStyle.getSubTitleStyle(
          context, 15, CustomColor.getTertieryColor(context)),
      maxLines: 5,
      decoration: InputDecoration(
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          hintText: descTitle,
          hintStyle: CustomTextStyle.getSubTitleStyle(context, 15, Colors.grey),
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
