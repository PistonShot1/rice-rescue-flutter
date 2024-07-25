import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:vhack_client/features/auth/domain/entity/user_entity.dart';
import 'package:vhack_client/features/auth/presentation/cubit/user/user_cubit.dart';
import 'package:vhack_client/features/team/domain/entity/team_entity.dart';
import 'package:vhack_client/features/team/presentation/cubit/team/single_team/single_team_cubit.dart';
import 'package:vhack_client/features/team/presentation/cubit/team/team_cubit.dart';
import 'package:vhack_client/features/team/presentation/screen/add_team_dialog.dart';
import 'package:vhack_client/presentation/components/button/icon_button.dart';
import 'package:vhack_client/presentation/components/button/text_button.dart';
import 'package:vhack_client/presentation/components/card/user_avatar_card.dart';
import 'package:vhack_client/presentation/components/card/team/user_member_card.dart';
import 'package:vhack_client/presentation/components/dialog/member/member_dialog.dart';
import 'package:vhack_client/presentation/screen/bridge_screen.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';
import 'package:vhack_client/shared/constant/custom_snackbar.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';
import 'package:vhack_client/injection_container.dart' as di;

class TeamMemberTabbar extends StatefulWidget {
  final UserEntity userEntity;
  const TeamMemberTabbar({super.key, required this.userEntity});

  @override
  State<TeamMemberTabbar> createState() => _TeamMemberTabbarState();
}

class _TeamMemberTabbarState extends State<TeamMemberTabbar> {
  List<Map<String, dynamic>> listUser = [
    {
      'userID': '1',
      'userName': 'Haris',
      'userAvatar':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXRPDQKY4pgjvClQRGa7bL37IKFG0FZiViZQ&usqp=CAU',
      'userPosition': 'Head of Farmer',
      'userStatus': 'Members'
    },
    {
      'userID': '2',
      'userName': 'Hakim',
      'userAvatar':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJJS324sJIJ0Hzx5TdBwWHD_7snDCzLX0FfA&usqp=CAU',
      'userPosition': 'Producers',
      'userStatus': 'Producers'
    },
    {
      'userID': '3',
      'userName': 'Haziq',
      'userAvatar':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlHTd7q7JcF6px8nAR6S7t2aD9b3oXazKuRA&usqp=CAU',
      'userPosition': 'Owner',
      'userStatus': 'Owner'
    },
    {
      'userID': '4',
      'userName': 'Irfan',
      'userAvatar':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjuNz23ISrNeyjlqMOWHYKXP-_9bQdrWcOnA&usqp=CAU',
      'userPosition': 'Irrigation Worker',
      'userStatus': 'Advisors'
    }
  ];
  String? teamID;
  final TextEditingController tcName = TextEditingController();
  List memberChips = [
    ['Members', false],
    ['Employees', false],
    ['Advisors', false],
    ['Producers', false]
  ];

  void setSelected(bool value, int index) {
    setState(() {
      memberChips[index][1] = value;
    });
    print('${memberChips[index][0]} ${memberChips[index][1]}');
  }

  void postTeam() {
    final List<UserEntity> selectedUsers =
        BlocProvider.of<UserCubit>(context).selectedUsers;

    BlocProvider.of<TeamCubit>(context)
        .postTeam(
            teamEntity: TeamEntity(
                teamByID: widget.userEntity.userID,
                teamMember: selectedUsers,
                teamName: tcName.text))
        .then((value) {
      Navigator.pop(context);
      BlocProvider.of<UserCubit>(context).reset();
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BridgeScreen(
          userID: widget.userEntity.userID,
        ),
      ));
    });

    print(selectedUsers);
  }

  void createTeam() {
    if (tcName.text.isEmpty) {
      Navigator.pop(context);
      SnackBarUtil.showSnackBar('Team name cannot be empty', Colors.red);
    } else {
      postTeam();
    }
  }

  void updateTeam(TeamEntity currentTeam) {
    List<UserEntity> selectedUser =
        BlocProvider.of<UserCubit>(context).selectedUsers;
    selectedUser.addAll(currentTeam.teamMember!);

    // for (var eachuser in currentTeam.teamMember!) {
    // print(currentTeam.teamMember!.length);
    //}
    BlocProvider.of<TeamCubit>(context)
        .updateTeam(
            teamEntity: TeamEntity(
                teamID: currentTeam.teamID, teamMember: selectedUser))
        .then((value) {
      selectedUser.clear();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => BridgeScreen(
            userID: widget.userEntity.userID,
          ),
        ),
        (route) => false,
      );
      setState(() {});
      BlocProvider.of<UserCubit>(context).reset();
    });
  }

  void removeMember(TeamEntity currentTeam, UserEntity userEntity) {
    List<UserEntity> updatedMembers = currentTeam.teamMember!
        .where((member) => member.userID != userEntity.userID)
        .toList();

    // Update the team with the new list of members
    BlocProvider.of<TeamCubit>(context)
        .updateTeam(
      teamEntity: TeamEntity(
        teamID: currentTeam.teamID,
        teamMember: updatedMembers,
      ),
    )
        .then((value) {
      setState(() {});
    });
  }

  @override
  void initState() {
    BlocProvider.of<SingleTeamCubit>(context)
        .getSingleJob(userID: widget.userEntity.userID!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColor.getPrimaryColor(context),
        body: buildBlocContent());
  }

  Widget buildButton(
    bool isCreated,
    TeamEntity? currentTeam,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (currentTeam != null)
            MaterialButton(
              color: CustomColor.getBackgroundColor(context),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              onPressed: () {
                print(currentTeam!.teamMember!.length);
                showCustomDialogAdd(
                  context,
                  currentTeam,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_outline,
                    color: CustomColor.getSecondaryColor(context),
                    size: 18,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Add Member',
                    style: CustomTextStyle.getTitleStyle(
                        context, 12, CustomColor.getSecondaryColor(context)),
                  ),
                ],
              ),
            ),
          const SizedBox(
            width: 10,
          ),
          if (!isCreated)
            MaterialButton(
              color: CustomColor.getBackgroundColor(context),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              onPressed: () {
                showCustomDialogCreate(context);
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
                    'Create Team',
                    style: CustomTextStyle.getTitleStyle(
                        context, 12, CustomColor.getSecondaryColor(context)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget buildBlocContent() {
    return BlocBuilder<SingleTeamCubit, SingleTeamState>(
      builder: (context, state) {
        if (state is SingleTeamLoaded) {
          List<UserEntity> myListTeam = state.teamEntity.teamMember!;
          print(myListTeam.length);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Text(
                  state.teamEntity.teamName!,
                  style: CustomTextStyle.getTitleStyle(
                      context, 21, CustomColor.getTertieryColor(context)),
                ),
              ),
              buildButton(
                true,
                state.teamEntity,
              ),
              const SizedBox(
                height: 10,
              ),
              buildListMember(myListTeam, state.teamEntity)
            ],
          );
        }
        if (state is SingleTeamFailure) {
          return Column(
            children: [
              buildButton(
                false,
                null,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    state.failureTitle,
                    style: CustomTextStyle.getTitleStyle(
                        context, 21, CustomColor.getSecondaryColor(context)),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          );
        }

        return CircularProgressIndicator(
          color: CustomColor.getSecondaryColor(context),
        );
      },
    );
  }

  Widget buildListChip() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: memberChips.length,
          itemBuilder: (context, index) {
            String eachMemberChip = memberChips[index][0];
            bool eachSelected = memberChips[index][1];
            return buildChip(eachMemberChip, eachSelected, index);
          },
        ),
      ),
    );
  }

  Widget buildChip(String eachMemberChip, bool eachSelected, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ChoiceChip(
        label: Text(eachMemberChip),
        labelStyle: CustomTextStyle.getTitleStyle(
            context,
            12,
            eachSelected
                ? CustomColor.getWhiteColor(context)
                : CustomColor.getTertieryColor(context)),
        backgroundColor: Colors.black12,
        selectedColor: CustomColor.getSecondaryColor(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        selected: eachSelected,
        onSelected: (value) {
          setSelected(value, index);
        },
      ),
    );
  }

  Widget buildListMember(
    List<UserEntity> myListTeam,
    TeamEntity currentTeam,
  ) {
    return Expanded(
        child: ListView.builder(
      itemCount: myListTeam.length,
      itemBuilder: (context, index) {
        return buildUserMemberCard(myListTeam[index], currentTeam);
      },
    ));
  }

  Widget buildUserMemberCard(
    UserEntity userEntity,
    TeamEntity currentTeam,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            backgroundColor: Colors.red,
            onPressed: (context) {
              removeMember(
                currentTeam,
                userEntity,
              );
            },
            icon: Icons.delete_forever_outlined,
          )
        ]),
        child: UserMemberCard(
          userEntity: userEntity,
        ),
      ),
    );
  }

  void showCustomDialogCreate(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return AddTeamDialog(
          userEntity: widget.userEntity,
          teamEntity: null,
          tcName: tcName,
          isCreated: true,
          onPressed: () {
            createTeam();
          },
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(0, -1), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(0, 1), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  void showCustomDialogAdd(
    BuildContext context,
    TeamEntity currentTeam,
  ) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return AddTeamDialog(
          userEntity: widget.userEntity,
          teamEntity: currentTeam,
          tcName: tcName,
          isCreated: false,
          onPressed: () {
            updateTeam(currentTeam);
          },
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(0, -1), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(0, 1), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }
}
