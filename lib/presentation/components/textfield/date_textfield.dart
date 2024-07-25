import 'package:flutter/material.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';

import '../../../shared/constant/custom_color.dart';

class DateTextField extends StatelessWidget {
  final TextEditingController tcDate;
  final void Function()? onTap;
  final String hintTextField;
  const DateTextField(
      {super.key,
      required this.tcDate,
      required this.onTap,
      required this.hintTextField});

  @override
  Widget build(BuildContext context) {
    return buildDateTextField(context);
  }

  Widget buildDateTextField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: CustomColor.getPrimaryColor(context),
          border: Border.all(color: Colors.grey, width: 0.5)),
      child: TextField(
          controller: tcDate,
          keyboardType: TextInputType.datetime,
          cursorColor: CustomColor.getSecondaryColor(context),
          style: CustomTextStyle.getSubTitleStyle(
              context, 15, CustomColor.getTertieryColor(context)),
          onTap: onTap,
          decoration: InputDecoration(
              hintText: hintTextField,
              hintStyle: CustomTextStyle.getSubTitleStyle(
                  context, 12, CustomColor.getTertieryColor(context)),
              prefixIcon: Icon(
                Icons.calendar_month_outlined,
                color: CustomColor.getSecondaryColor(context),
              ),
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none)),
    );
  }
}
