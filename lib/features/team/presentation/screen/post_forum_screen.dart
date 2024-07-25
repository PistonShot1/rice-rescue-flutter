import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vhack_client/features/auth/domain/entity/user_entity.dart';
import 'package:vhack_client/features/team/domain/entity/forum_entity.dart';
import 'package:vhack_client/features/team/presentation/cubit/forum/forum_cubit.dart';
import 'package:vhack_client/presentation/components/button/text_button.dart';
import 'package:vhack_client/presentation/components/image/mynetwork_image.dart';
import 'package:vhack_client/shared/constant/custom_appbar.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';
import 'package:vhack_client/shared/constant/custom_snackbar.dart';
import 'package:vhack_client/shared/constant/custom_string.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';

class PostForumScreen extends StatefulWidget {
  final UserEntity userEntity;
  const PostForumScreen({super.key, required this.userEntity});

  @override
  State<PostForumScreen> createState() => _PostForumScreenState();
}

class _PostForumScreenState extends State<PostForumScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController tcContent = TextEditingController();
  bool isLoading = false;

  void postForum() {
    setState(() {
      isLoading = true;
    });
    BlocProvider.of<ForumCubit>(context)
        .postForum(
            forumEntity: ForumEntity(
                forumContent: tcContent.text,
                forumByID: widget.userEntity.userID,
                forumLocation: 'Kuala Lumpur, Malaysia'))
        .then((value) {
      setState(() {
        isLoading = false;
      });
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: CustomColor.getBackgroundColor(context),
        appBar: CustomAppBar.BuildMainAppBar(context, false),
        body: Column(
          children: [buildHeader(), buildButton()],
        ));
  }

  Widget buildHeader() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyNetworkImage(
                pathURL: widget.userEntity.userAvatar!.avatarURL,
                width: 50,
                height: 50,
                radius: 50),
            const SizedBox(
              width: 10,
            ),
            buildForm()
          ],
        ),
      ),
    );
  }

  Widget buildForm() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.userEntity.userName!,
            style: CustomTextStyle.getTitleStyle(
                context, 15, CustomColor.getTertieryColor(context)),
          ),
          Expanded(
            child: TextField(
              controller: tcContent,
              keyboardType: TextInputType.text,
              autofocus: true,
              minLines: 1,
              maxLines: 10,
              cursorColor: CustomColor.getSecondaryColor(context),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'What happening?',
                  hintStyle: CustomTextStyle.getSubTitleStyle(
                      context, 15, Colors.grey)),
            ),
          )
        ],
      ),
    );
  }

  Widget buildButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
      child: TextOnlyButton(
          buttonTitle: isLoading ? 'Loading...' : 'Post',
          onPressed: () {
            if (tcContent.text.isEmpty) {
              SnackBarUtil.showSnackBar('Fill cannot be empty', Colors.red);
            } else {
              postForum();
            }
          },
          isMain: true,
          borderRadius: 32),
    );
  }
}
