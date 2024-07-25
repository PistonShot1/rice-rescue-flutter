import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vhack_client/features/auth/domain/entity/user_entity.dart';
import 'package:vhack_client/features/auth/presentation/cubit/user/user_cubit.dart';
import 'package:vhack_client/injection_container.dart' as di;
import '../../../../shared/constant/custom_color.dart';
import '../../../../shared/constant/custom_textstyle.dart';
import '../../button/icon_button.dart';

class MemberDialog extends StatefulWidget {
  final String id;
  final void Function()? onPressed;
  final String title, desc, buttonTitle;

  const MemberDialog(
      {super.key,
      required this.id,
      required this.onPressed,
      required this.title,
      required this.desc,
      required this.buttonTitle});

  @override
  State<MemberDialog> createState() => _MemberDialogState();
}

class _MemberDialogState extends State<MemberDialog> {
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
    return buildMemberDialog(context);
  }

  Widget buildMemberDialog(BuildContext context) {
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
            children: [
              buildHeader(context),
              const SizedBox(
                height: 10,
              ),
              if (widget.id == 'team') buildTextField(context),
              const SizedBox(
                height: 10,
              ),
              if (BlocProvider.of<UserCubit>(context).selectedUsers.isNotEmpty)
                buildSelectedUsers(),
              const SizedBox(
                height: 10,
              ),
              buildBlocListUser(context),
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

  Widget buildHeader(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: CustomTextStyle.getTitleStyle(
                context, 18, CustomColor.getTertieryColor(context)),
          ),
          Text(
            widget.desc,
            style: CustomTextStyle.getTitleStyle(
                context, 12, CustomColor.getTertieryColor(context)),
          ),
        ],
      );

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
                print(users[index]);
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
                child: Text(widget.buttonTitle,
                    style: CustomTextStyle.getTitleStyle(
                        context, 12, CustomColor.getWhiteColor(context)))),
          ),
        ],
      );
}
