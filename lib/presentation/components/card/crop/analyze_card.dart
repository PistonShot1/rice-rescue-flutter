import 'package:flutter/material.dart';
import 'package:vhack_client/features/crop/domain/entity/crop_entity.dart';
import 'package:vhack_client/presentation/components/card/user_avatar_card.dart';
import 'package:vhack_client/presentation/components/image/mynetwork_image.dart';
import 'package:vhack_client/shared/constant/custom_date.dart';

import '../../../../shared/constant/custom_color.dart';
import '../../../../shared/constant/custom_textstyle.dart';

class AnalyzeCard extends StatelessWidget {
  final CropEntity cropEntity;
  const AnalyzeCard({super.key, required this.cropEntity});

  Color selectedColor(String fieldCA) {
    Color? color;
    switch (fieldCA) {
      case 'Rainfed Lowland':
        color = Colors.orange.shade700;
        break;
      case 'Irrigated Lowland':
        color = Colors.yellow.shade700;
        break;
      case 'Upland':
        color = Colors.green.shade700;
        break;
      default:
        color = Colors.red;
    }
    return color;
  }

  Color selectedBgColor(String fieldCA) {
    Color? color;
    switch (fieldCA) {
      case 'Rainfed Lowland':
        color = Colors.orange.shade100;
        break;
      case 'Irrigated Lowland':
        color = Colors.yellow.shade100;
        break;
      case 'Upland':
        color = Colors.green.shade100;
        break;
      default:
        color = Colors.red;
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.circular(16),
          color: CustomColor.getPrimaryColor(context)),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: MyNetworkImage(
            pathURL: cropEntity.cropImage!.avatarURL,
            width: 50,
            height: 50,
            radius: 50),
        title: Text(
          cropEntity.cropDisease!,
          style: CustomTextStyle.getTitleStyle(
              context, 15, CustomColor.getTertieryColor(context)),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cropEntity.cropPrecaution!,
              style: CustomTextStyle.getSubTitleStyle(
                  context, 12, CustomColor.getTertieryColor(context)),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    buildInfo(
                        context,
                        Icons.timelapse_outlined,
                        ConvertDate.convertDateString(
                            cropEntity.cropDate.toString())),
                    const SizedBox(
                      width: 20,
                    ),
                    buildInfo(context, Icons.health_and_safety_outlined,
                        cropEntity.cropNutrient!)
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: selectedBgColor(cropEntity.cropCA!)),
                  child: Text(
                    cropEntity.cropCA!,
                    style: CustomTextStyle.getTitleStyle(
                        context, 12, selectedColor(cropEntity.cropCA!)),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfo(BuildContext context, IconData iconData, String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          iconData,
          color: Colors.grey,
          size: 16,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          title,
          style: CustomTextStyle.getSubTitleStyle(
              context, 12, CustomColor.getTertieryColor(context)),
        ),
      ],
    );
  }
}
