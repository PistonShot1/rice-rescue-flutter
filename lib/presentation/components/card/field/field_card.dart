import 'package:flutter/material.dart';
import 'package:vhack_client/features/field/domain/entity/field_entity.dart';

import '../../../../shared/constant/custom_color.dart';
import '../../../../shared/constant/custom_textstyle.dart';

class FieldCard extends StatelessWidget {
  final FieldEntity eachField;
  const FieldCard({super.key, required this.eachField});

  Color selectedColor(String fieldCA) {
    Color? color;
    switch (fieldCA) {
      case 'Rainfed Lowland':
        color = Colors.orange;
        break;
      case 'Irrigated Lowland':
        color = Colors.yellow;
        break;
      case 'Upland':
        color = Colors.green;
        break;
      default:
        color = Colors.red;
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return buildContent(context);
  }

  Widget buildContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: CustomColor.getPrimaryColor(context),
          border: Border.all(color: Colors.grey, width: 0.5)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 120,
            width: 10,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12)),
                color: selectedColor(eachField.fieldCA!)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  buildHeader(context),
                  const SizedBox(
                    height: 20,
                  ),
                  buildBottom(context)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          eachField.fieldName!,
          style: CustomTextStyle.getTitleStyle(
              context, 18, CustomColor.getTertieryColor(context)),
        ),
        Text(
          'Mar 27 2024',
          style: CustomTextStyle.getSubTitleStyle(
              context, 12, CustomColor.getTertieryColor(context)),
        )
      ],
    );
  }

  Widget buildBottom(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Paddy Crop Type',
              style: CustomTextStyle.getTitleStyle(context, 12, Colors.grey),
            ),
            Text(
              eachField.fieldCA!,
              style: CustomTextStyle.getTitleStyle(
                  context, 15, CustomColor.getTertieryColor(context)),
            )
          ],
        ),
        Container(
          width: 2,
          height: 20,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32), color: Colors.grey),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cultivation Area',
              style: CustomTextStyle.getTitleStyle(context, 12, Colors.grey),
            ),
            Text(
              eachField.fieldCA!,
              style: CustomTextStyle.getTitleStyle(
                  context, 15, CustomColor.getTertieryColor(context)),
            )
          ],
        ),
      ],
    );
  }
}
