import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';

import '../../../shared/constant/custom_color.dart';

class TimeLineDate extends StatelessWidget {
  final void Function(DateTime)? onDateChange;

  const TimeLineDate({super.key, required this.onDateChange});

  @override
  Widget build(BuildContext context) {
    return buildDatePicker(context);
  }

  DatePicker buildDatePicker(BuildContext context) {
    return DatePicker(DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        dateTextStyle: CustomTextStyle.getTitleStyle(
            context, 25, CustomColor.getTertieryColor(context)),
        dayTextStyle: CustomTextStyle.getTitleStyle(
            context, 11, CustomColor.getTertieryColor(context)),
        monthTextStyle: CustomTextStyle.getTitleStyle(
            context, 11, CustomColor.getTertieryColor(context)),
        selectionColor: CustomColor.getSecondaryColor(context),
        selectedTextColor: Colors.white,
        onDateChange: onDateChange);
  }
}
