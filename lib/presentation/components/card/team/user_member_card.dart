import 'package:flutter/material.dart';
import 'package:vhack_client/features/auth/domain/entity/user_entity.dart';
import 'package:vhack_client/presentation/components/card/user_avatar_card.dart';
import 'package:vhack_client/shared/constant/custom_string.dart';

import '../../../../shared/constant/custom_color.dart';
import '../../../../shared/constant/custom_textstyle.dart';

class UserMemberCard extends StatelessWidget {
  final UserEntity userEntity;
  const UserMemberCard({super.key, required this.userEntity});

  @override
  Widget build(BuildContext context) {
    return buildUserMemberCard(context);
  }

  Widget buildUserMemberCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey, width: 0.5),
          color: CustomColor.getBackgroundColor(context)),
      child: ListTile(
          leading: UserAvatarCard(
              userAvatar: userEntity.userAvatar!.avatarURL, radius: 40),
          title: Text(
            userEntity.userName!,
            style: CustomTextStyle.getTitleStyle(
                context, 15, CustomColor.getTertieryColor(context)),
          ),
          subtitle: Text(
            userEntity.userRole!,
            style: CustomTextStyle.getTitleStyle(
                context, 12, CustomColor.getSecondaryColor(context)),
          ),
          trailing: buildTrailing(context)),
    );
  }

  Widget buildTrailing(BuildContext context) {
    if (userEntity.userType == 'Owner') {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.green, width: 0.5),
            borderRadius: BorderRadius.circular(8),
            color: Colors.green.shade100),
        child: Text(
          userEntity.userType!,
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
          userEntity.userType!,
          style: CustomTextStyle.getTitleStyle(context, 12, Colors.black54),
        ),
      );
    }
  }
}
