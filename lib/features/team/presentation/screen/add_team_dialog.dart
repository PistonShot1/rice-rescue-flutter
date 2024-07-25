import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vhack_client/features/auth/domain/entity/user_entity.dart';
import 'package:vhack_client/features/auth/presentation/cubit/user/user_cubit.dart';
import 'package:vhack_client/features/team/domain/entity/team_entity.dart';
import 'package:vhack_client/injection_container.dart' as di;
import '../../../../shared/constant/custom_color.dart';
import '../../../../shared/constant/custom_textstyle.dart';
import '../cubit/team/single_team/single_team_cubit.dart';

class AddTeamDialog extends StatefulWidget {
  final UserEntity userEntity;
  final TeamEntity? teamEntity;
  final TextEditingController tcName;
  final void Function()? onPressed;
  final bool isCreated;

  const AddTeamDialog(
      {super.key,
      required this.userEntity,
      required this.teamEntity,
      required this.tcName,
      required this.onPressed,
      required this.isCreated});

  @override
  State<AddTeamDialog> createState() => _AddTeamDialogState();
}

class _AddTeamDialogState extends State<AddTeamDialog> {
  bool isSelected(BuildContext context, UserEntity userEntity) {
    return BlocProvider.of<UserCubit>(context).isSelected(userEntity);
  }

  void handleUser(BuildContext context, UserEntity userEmail) {
    BlocProvider.of<UserCubit>(context).selectUser(userEmail);
    setState(() {});
  }

  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildAddTeamDialog(context);
  }

  Widget buildAddTeamDialog(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: CustomColor.getPrimaryColor(context)),
        height: 500,
        child: Material(
          type: MaterialType.transparency,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeader(context),
              const SizedBox(
                height: 10,
              ),
              if (widget.isCreated) buildTextField(context),
              const SizedBox(
                height: 10,
              ),
              if (BlocProvider.of<UserCubit>(context).selectedUsers.isNotEmpty)
                buildSelectedUsers(),
              const SizedBox(
                height: 10,
              ),
              buildList(),
              const SizedBox(
                height: 10,
              ),
              buildButtom(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    if (widget.isCreated) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create Team',
            style: CustomTextStyle.getTitleStyle(
                context, 18, CustomColor.getTertieryColor(context)),
          ),
          Text(
            'in just a simple click.',
            style: CustomTextStyle.getSubTitleStyle(
                context, 12, CustomColor.getTertieryColor(context)),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Edit team',
            style: CustomTextStyle.getTitleStyle(
                context, 18, CustomColor.getTertieryColor(context)),
          ),
          Text(
            'in just a simple click.',
            style: CustomTextStyle.getSubTitleStyle(
                context, 12, CustomColor.getTertieryColor(context)),
          ),
        ],
      );
    }
  }

  Widget buildSelectedUsers() => SizedBox(
        height: 30,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: BlocProvider.of<UserCubit>(context).selectedUsers.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: CustomColor.getSecondaryColor(context)),
                  child: Center(
                    child: Text(
                      BlocProvider.of<UserCubit>(context)
                          .selectedUsers[index]
                          .userEmail!,
                      style: CustomTextStyle.getTitleStyle(
                          context, 12, CustomColor.getWhiteColor(context)),
                    ),
                  )),
            );
          },
        ),
      );

  Widget buildTextField(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Team Name',
            style: CustomTextStyle.getTitleStyle(
                context, 15, CustomColor.getTertieryColor(context)),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: widget.tcName,
            keyboardType: TextInputType.text,
            cursorColor: CustomColor.getSecondaryColor(context),
            style: CustomTextStyle.getSubTitleStyle(
                context, 12, CustomColor.getTertieryColor(context)),
            decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: CustomColor.getSecondaryColor(context),
                        width: 2))),
          ),
        ],
      );

  Widget buildList() {
    if (widget.isCreated) {
      return buildBlocListUser(context);
    } else {
      return buildBlocListUserTeam(context);
    }
  }

  Widget buildBlocListUser(BuildContext context) {
    return Expanded(
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoaded) {
            return buildListUser(state.users);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget buildBlocListUserTeam(BuildContext context) {
    return Expanded(
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          List<UserEntity> list = [];
          if (state is UserLoaded) {
            /* List<UserEntity> list = state.users
                .where((user) => widget.teamEntity!.teamMember!
                    .any((member) => member.userID == user.userID))
                .toList();*/

            if (widget.teamEntity!.teamMember!.isEmpty) {
              list.addAll(state.users);
            } else {
              /* for (var eachuser in state.users) {
                for (var eachMember in widget.teamEntity!.teamMember!) {
                  if (eachMember.userID != eachuser.userID) {
                    list.add(eachuser);
                  }
                }
              }*/
              list = state.users
                  .where((user) => !widget.teamEntity!.teamMember!
                      .any((member) => member.userID == user.userID))
                  .toList();
            }

            return buildListUser(list);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget buildListUser(List<UserEntity> users) => SingleChildScrollView(
        child: Column(
          children: List.generate(users.length, (index) {
            return ListTile(
              title: Text(
                users[index].userName!,
                style: CustomTextStyle.getTitleStyle(
                    context, 12, CustomColor.getTertieryColor(context)),
              ),
              subtitle: Text(
                users[index].userEmail!,
                style: CustomTextStyle.getSubTitleStyle(
                    context, 12, CustomColor.getTertieryColor(context)),
              ),
              trailing: isSelected(context, users[index])
                  ? Icon(
                      Icons.check_circle,
                      color: CustomColor.getSecondaryColor(context),
                    )
                  : const Icon(
                      Icons.check_circle_outline,
                      color: Colors.grey,
                    ),
              onTap: () {
                handleUser(context, users[index]);
              },
            );
          }),
        ),
      );

  Widget buildButtom(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MaterialButton(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: CustomColor.getTertieryColor(context)),
                borderRadius: BorderRadius.circular(12)),
            onPressed: () {
              BlocProvider.of<UserCubit>(context).reset();
              Navigator.pop(context);
            },
            child: Center(
                child: Text('Cancel',
                    style: CustomTextStyle.getTitleStyle(
                        context, 12, CustomColor.getTertieryColor(context)))),
          ),
          MaterialButton(
            color: CustomColor.getSecondaryColor(context),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onPressed: widget.onPressed,
            child: Center(
                child: Text(widget.isCreated ? "Created Team" : "Add",
                    style: CustomTextStyle.getTitleStyle(
                        context, 12, CustomColor.getWhiteColor(context)))),
          ),
        ],
      );
}
