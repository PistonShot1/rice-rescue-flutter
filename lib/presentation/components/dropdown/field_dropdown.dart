import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:vhack_client/features/field/domain/entity/field_entity.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';

import '../../../shared/constant/custom_color.dart';

class FieldDropDown extends StatelessWidget {
  final List<FieldEntity> fields;
  final FieldEntity? selectedField;
  final void Function(dynamic)? onChanged;

  const FieldDropDown({
    super.key,
    required this.fields,
    required this.selectedField,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return buildDropDownField(context);
  }

  Widget buildDropDownField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: CustomColor.getPrimaryColor(context)),
      child: DropdownButton<FieldEntity>(
        borderRadius: BorderRadius.circular(12),
        hint: Text(
          'Your Fields',
          style: CustomTextStyle.getSubTitleStyle(context, 15, Colors.grey),
        ),
        value: selectedField,
        items: fields.map((valueItem) {
          return DropdownMenuItem<FieldEntity>(
              value: valueItem,
              child: Text(
                valueItem.fieldName!,
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
