import 'package:flutter/material.dart';

import '../../../shared/constant/custom_color.dart';
import '../../../shared/constant/custom_textstyle.dart';

class FieldTextField extends StatelessWidget {
  final TextEditingController tcField;
  final void Function()? onTap;
  const FieldTextField({super.key, required this.tcField, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return buildFieldTextField(context);
  }

  Widget buildFieldTextField(BuildContext context) {
    return TextField(
      controller: tcField,
      keyboardType: TextInputType.text,
      cursorColor: CustomColor.getSecondaryColor(context),
      onTap: onTap,
      decoration: InputDecoration(
          hintText: 'Field Name',
          hintStyle: CustomTextStyle.getSubTitleStyle(context, 15, Colors.grey),
          prefixIcon: Icon(
            Icons.area_chart,
            color: CustomColor.getSecondaryColor(context),
          ),
          suffixIcon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.grey,
            size: 32,
          ),
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  BorderSide(color: CustomColor.getSecondaryColor(context)))),
    );
  }
}
