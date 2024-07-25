import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';

import '../../../shared/constant/custom_color.dart';

class MyDropDown extends StatelessWidget {
  final List<String> inputs;
  final String? selectedInput;
  final void Function(dynamic)? onChanged;
  final String dropdownTitle;

  const MyDropDown(
      {super.key,
      required this.inputs,
      required this.selectedInput,
      required this.onChanged,
      required this.dropdownTitle});

  @override
  Widget build(BuildContext context) {
    return buildDropDownField(context);
  }

  Widget buildDropDownField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(12),
          color: CustomColor.getBackgroundColor(context)),
      child: DropdownButton<String>(
        underline: Container(),
        borderRadius: BorderRadius.circular(12),
        hint: Text(
          dropdownTitle,
          style: CustomTextStyle.getSubTitleStyle(context, 15, Colors.grey),
        ),
        value: selectedInput,
        items: inputs.map((valueItem) {
          return DropdownMenuItem<String>(
              value: valueItem.toString(),
              child: Text(
                valueItem,
                style: CustomTextStyle.getSubTitleStyle(
                    context, 15, CustomColor.getTertieryColor(context)),
              ));
        }).toList(),
        onChanged: onChanged,
        iconSize: 24,
        isExpanded: true,
        dropdownColor: CustomColor.getPrimaryColor(context),
        menuMaxHeight: 400,
      ),
    );
  }
}
