import 'package:flutter/material.dart';

import '../../../shared/constant/custom_color.dart';
import '../../../shared/constant/custom_textstyle.dart';

class MetricDropdown extends StatelessWidget {
  final List<String> values;
  final String? selectedValue;
  final void Function(dynamic)? onChanged;
  const MetricDropdown(
      {super.key,
      required this.values,
      required this.selectedValue,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return buildDropDown(context);
  }

  Widget buildDropDown(BuildContext context) {
    return Container(
      height: 50,
      width: 150,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.circular(12),
          color: CustomColor.getPrimaryColor(context)),
      child: DropdownButton<String>(
        borderRadius: BorderRadius.circular(12),
        hint: Text(
          'Your Fields',
          style: CustomTextStyle.getSubTitleStyle(context, 15, Colors.grey),
        ),
        value: selectedValue,
        items: values.map((valueItem) {
          return DropdownMenuItem<String>(
              value: valueItem.toString(),
              child: Text(
                valueItem,
                style: CustomTextStyle.getSubTitleStyle(
                    context, 15, CustomColor.getTertieryColor(context)),
              ));
        }).toList(),
        onChanged: onChanged,
        isExpanded: true,
        dropdownColor: CustomColor.getPrimaryColor(context),
        menuMaxHeight: 400,
      ),
    );
  }
}
