import 'package:flutter/material.dart';

import '../../../../shared/constant/custom_color.dart';
import '../../../../shared/constant/custom_textstyle.dart';

class ServiceCard extends StatelessWidget {
  final String serviceTitle, serviceDesc;
  final IconData serviceIcon;
  const ServiceCard(
      {super.key,
      required this.serviceTitle,
      required this.serviceDesc,
      required this.serviceIcon});

  @override
  Widget build(BuildContext context) {
    return buildServiceCard(context);
  }

  Widget buildServiceCard(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: CustomColor.getBackgroundColor(context)),
          child: Icon(
            serviceIcon,
            size: 34,
            color: CustomColor.getSecondaryColor(context),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              serviceTitle,
              style: CustomTextStyle.getTitleStyle(
                  context, 15, CustomColor.getTertieryColor(context)),
            ),
            subtitle: Text(
              serviceDesc,
              style: CustomTextStyle.getSubTitleStyle(
                  context, 12, CustomColor.getTertieryColor(context)),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
