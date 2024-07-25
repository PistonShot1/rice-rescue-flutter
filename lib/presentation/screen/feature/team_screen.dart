import 'package:flutter/material.dart';
import 'package:vhack_client/features/auth/domain/entity/user_entity.dart';
import 'package:vhack_client/features/team/presentation/screen/team_forum_tabbar.dart';
import 'package:vhack_client/features/team/presentation/screen/team_member_tabbar.dart';
import 'package:vhack_client/shared/constant/custom_appbar.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';

class TeamScreen extends StatefulWidget {
  final UserEntity userEntity;
  const TeamScreen({super.key, required this.userEntity});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColor.getBackgroundColor(context),
        appBar: CustomAppBar.BuildMainAppBar(context, false),
        body: Column(
          children: [
            buildHeader(),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(16),
                    color: CustomColor.getPrimaryColor(context)),
                child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        buildTabBar(),
                        Expanded(
                          child: TabBarView(children: [
                            TeamMemberTabbar(
                              userEntity: widget.userEntity,
                            ),
                            TeamForumTabbar(
                              userEntity: widget.userEntity,
                            )
                          ]),
                        )
                      ],
                    )),
              ),
            ))
          ],
        ));
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Community',
            style: CustomTextStyle.getTitleStyle(
                context, 18, CustomColor.getTertieryColor(context)),
          ),
          Text(
            'Connect with the community and manage your members',
            style: CustomTextStyle.getSubTitleStyle(
                context, 12, CustomColor.getTertieryColor(context)),
          )
        ],
      ),
    );
  }

  Widget buildTabBar() {
    return TabBar(
        unselectedLabelColor: Colors.grey,
        labelColor: CustomColor.getSecondaryColor(context),
        labelStyle: CustomTextStyle.getTitleStyle(
            context, 14, CustomColor.getSecondaryColor(context)),
        tabs: const [
          Tab(
            text: 'Team',
          ),
          Tab(
            text: 'Forum',
          )
        ]);
  }

  Widget buildSilverAppBar() {
    return SliverAppBar(
      pinned: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      shape: Border(
          bottom: BorderSide(
              color: const Color(0xFFAAAAAA).withOpacity(1), width: 1)),
      bottom: PreferredSize(
          preferredSize: Size.zero,
          child: TabBar(
              unselectedLabelColor: Colors.grey,
              labelColor: Theme.of(context).colorScheme.tertiary,
              indicatorColor: CustomColor.getSecondaryColor(context),
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 32),
              indicatorWeight: 5,
              tabs: [
                Tab(
                  child: Text('Members',
                      style: CustomTextStyle.getTitleStyle(
                          context, 15, CustomColor.getTertieryColor(context))),
                ),
                Tab(
                  child: Text('Forums',
                      style: CustomTextStyle.getTitleStyle(
                          context, 15, CustomColor.getTertieryColor(context))),
                )
              ])),
    );
  }
}
