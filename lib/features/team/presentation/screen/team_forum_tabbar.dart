import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:vhack_client/features/auth/domain/entity/user_entity.dart';
import 'package:vhack_client/features/team/presentation/cubit/forum/forum_cubit.dart';
import 'package:vhack_client/features/team/presentation/screen/post_forum_screen.dart';
import 'package:vhack_client/presentation/components/card/team/team_forum_card.dart';
import 'package:vhack_client/presentation/components/card/user_avatar_card.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';
import 'package:vhack_client/shared/constant/custom_string.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';

import '../../domain/entity/forum_entity.dart';

class TeamForumTabbar extends StatefulWidget {
  final UserEntity userEntity;
  const TeamForumTabbar({super.key, required this.userEntity});

  @override
  State<TeamForumTabbar> createState() => _TeamForumTabbarState();
}

class _TeamForumTabbarState extends State<TeamForumTabbar> {
  List<Map<String, dynamic>> listForum = [
    {
      'userID': '1',
      'userName': 'Hakim',
      'userAvatar':
          'https://media.istockphoto.com/id/1476170969/photo/portrait-of-young-man-ready-for-job-business-concept.webp?b=1&s=170667a&w=0&k=20&c=FycdXoKn5StpYCKJ7PdkyJo9G5wfNgmSLBWk3dI35Zw=',
      'messageContent':
          'Today, I started transplanting the seedlings into the main field. The weather has been cooperative, and the soil moisture seems adequate for planting. Hoping for a successful growing season!',
      'messageAt': '10:30 PM',
      'userFrom': 'Penang, Malaysia'
    },
    {
      'userID': '2',
      'userName': 'Haris Azhari',
      'userAvatar':
          'https://img.freepik.com/free-photo/cute-smiling-young-man-with-bristle-looking-satisfied_176420-18989.jpg',
      'messageContent':
          'Checked on my paddy fields today and noticed some signs of nutrient deficiency in a few areas. Planning to conduct soil tests tomorrow to determine the appropriate fertilization strategy. Anyone else facing similar issues?',
      'messageAt': '6:30 PM',
      'userFrom': 'Penang, Malaysia'
    },
    {
      'userID': '3',
      'userName': 'Zaharudin Hamid',
      'userAvatar':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkqKfqsbd-YbQMjHuukKhJZ028SG2T9I5FjNw7GEefcLQc_b40Kw27bOkpV2GInDoKdrU&usqp=CAU',
      'messageContent':
          'Been dealing with stubborn pests attacking my paddy plants lately. Tried various pest control methods, but they seem relentless. Any advice on effective pest management strategies?',
      'messageAt': '3:47 PM',
      'userFrom': 'Kedah, Malaysia'
    },
    {
      'userID': '4',
      'userName': 'Tan Dylan',
      'userAvatar':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMmTq0EkraPmBTgQPcd7ykHOd5PPF7R1CLjlkRPFQj9Pw_RHY-zsm6UwURYlNi2oCVZzk&usqp=CAU',
      'messageContent':
          'Harvested my first batch of paddy today, and I couldn\'t be happier with the yield! The hard work throughout the season has paid off. Ready to start the drying process and prepare for the next planting cycle.',
      'messageAt': '1:32 PM',
      'userFrom': 'Serdang, Malaysia'
    },
  ];

  @override
  void initState() {
    BlocProvider.of<ForumCubit>(context).getForums();
    super.initState();
  }

  void deleteForum(String forumID) {
    BlocProvider.of<ForumCubit>(context).deleteForum(forumID: forumID);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForumCubit, ForumState>(
      builder: (context, state) {
        if (state is ForumLoaded) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildButton(context),
                ],
              ),
              Expanded(child: buildListForum(state.forums)),
            ],
          );
        }
        if (state is ForumEmpty) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildButton(context),
                ],
              ),
              Expanded(
                child: Center(
                  child: Text(
                    state.emptyTitle,
                    style: CustomTextStyle.getSubTitleStyle(
                        context, 15, CustomColor.getTertieryColor(context)),
                  ),
                ),
              ),
            ],
          );
        }
        if (state is ForumFailure) {
          return Center(
            child: Text(
              state.failureTitle,
              style: CustomTextStyle.getTitleStyle(
                  context, 21, CustomColor.getSecondaryColor(context)),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget buildListForum(List<ForumEntity> forums) {
    return ListView.builder(
      itemCount: forums.length,
      itemBuilder: (context, index) {
        return buildTeamForumCard(forums[index]);
      },
    );
  }

  Widget buildTeamForumCard(ForumEntity eachForum) {
    return Column(
      children: [
        Slidable(
          endActionPane: ActionPane(motion: const StretchMotion(), children: [
            SlidableAction(
              icon: Icons.delete_outline,
              backgroundColor: Colors.red,
              onPressed: (context) {
                deleteForum(eachForum.forumID!);
              },
            )
          ]),
          child: TeamForumCard(
            eachForum: eachForum,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Divider(
          color: Colors.grey,
          height: 1,
        )
      ],
    );
  }

  Widget buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        color: CustomColor.getBackgroundColor(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                PostForumScreen(userEntity: widget.userEntity),
          ));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: CustomColor.getSecondaryColor(context),
              size: 18,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              'Post Something',
              style: CustomTextStyle.getTitleStyle(
                  context, 12, CustomColor.getSecondaryColor(context)),
            ),
          ],
        ),
      ),
    );
  }
}
