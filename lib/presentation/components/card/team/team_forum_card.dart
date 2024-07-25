import 'package:flutter/material.dart';
import 'package:vhack_client/features/team/domain/entity/forum_entity.dart';
import 'package:vhack_client/shared/constant/custom_date.dart';

import '../../../../shared/constant/custom_color.dart';
import '../../../../shared/constant/custom_string.dart';
import '../../../../shared/constant/custom_textstyle.dart';
import '../user_avatar_card.dart';

class TeamForumCard extends StatelessWidget {
  final ForumEntity eachForum;
  const TeamForumCard({super.key, required this.eachForum});

  @override
  Widget build(BuildContext context) {
    return buildTeamForumCard(context);
  }

  Widget buildTeamForumCard(BuildContext context) {
    return ListTile(
      leading: UserAvatarCard(
          userAvatar: eachForum.forumBy!.userAvatar!.avatarURL, radius: 40),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            eachForum.forumBy!.userName!,
            style: CustomTextStyle.getTitleStyle(
                context, 12, CustomColor.getTertieryColor(context)),
          ),
          Text(
            ConvertDate.convertDateHourString(
                eachForum.forumAt!.toIso8601String()),
            style: CustomTextStyle.getTitleStyle(
                context, 10, CustomColor.getTertieryColor(context)),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            eachForum.forumContent!,
            style: CustomTextStyle.getSubTitleStyle(
              context,
              12,
              CustomColor.getTertieryColor(context),
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            eachForum.forumLocation!,
            style: CustomTextStyle.getTitleStyle(
                context, 12, CustomColor.getTertieryColor(context)),
          ),
        ],
      ),
    );
  }
}
