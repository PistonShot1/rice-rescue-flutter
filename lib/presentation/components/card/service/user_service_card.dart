import 'package:flutter/material.dart';
import 'package:vhack_client/presentation/components/image/mynetwork_image.dart';

import '../../../../shared/constant/custom_color.dart';
import '../../../../shared/constant/custom_string.dart';
import '../../../../shared/constant/custom_textstyle.dart';
import '../user_avatar_card.dart';

class UserServiceCard extends StatelessWidget {
  final Map<String, dynamic> userEntity;
  final VoidCallback voidCallback;
  const UserServiceCard(
      {super.key, required this.userEntity, required this.voidCallback});

  @override
  Widget build(BuildContext context) {
    return buildUserServiceCard(context);
  }

  Widget buildUserServiceCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: CustomColor.getPrimaryColor(context),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey, width: 0.5)),
      child: ListTile(
        onTap: voidCallback,
        contentPadding: EdgeInsets.zero,
        leading: MyNetworkImage(
            pathURL: userEntity['userAvatar'],
            width: 50,
            height: 50,
            radius: 50),
        title: Text(
          userEntity['userName'],
          style: CustomTextStyle.getTitleStyle(
              context, 15, CustomColor.getTertieryColor(context)),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userEntity['userJobType'],
              style: CustomTextStyle.getSubTitleStyle(
                  context, 12, CustomColor.getTertieryColor(context)),
            ),
            Text(
              userEntity['userCompanyName'],
              style: CustomTextStyle.getTitleStyle(
                  context, 12, CustomColor.getSecondaryColor(context)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTrailing(
    BuildContext context,
  ) {
    if (userEntity['userStatus']) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.green, width: 0.5),
            borderRadius: BorderRadius.circular(8),
            color: Colors.green.shade100),
        child: Text(
          'Active',
          style: CustomTextStyle.getTitleStyle(context, 12, Colors.black54),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.red, width: 0.5),
            borderRadius: BorderRadius.circular(8),
            color: Colors.red.shade100),
        child: Text(
          'Inactive',
          style: CustomTextStyle.getTitleStyle(context, 12, Colors.black54),
        ),
      );
    }
  }
}
