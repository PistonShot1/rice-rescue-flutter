import 'package:flutter/material.dart';

import '../../../../shared/constant/custom_color.dart';
import '../../../../shared/constant/custom_textstyle.dart';

class ResultCard extends StatelessWidget {
  final String resultTitle, resultDetail;
  final IconData resultIcon;
  const ResultCard(
      {super.key,
      required this.resultIcon,
      required this.resultTitle,
      required this.resultDetail});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
        color: CustomColor.getPrimaryColor(context),
      ),
      child: Row(
        children: [
          Icon(
            resultIcon,
            size: 30,
            color: CustomColor.getSecondaryColor(context),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(resultTitle,
                  style: CustomTextStyle.getTitleStyle(
                    context,
                    15,
                    CustomColor.getTertieryColor(context),
                  )),
              Text(resultDetail,
                  style: CustomTextStyle.getSubTitleStyle(
                    context,
                    12,
                    CustomColor.getTertieryColor(context),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
