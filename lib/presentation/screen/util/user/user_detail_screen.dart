import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vhack_client/presentation/components/button/small_button.dart';
import 'package:vhack_client/presentation/components/button/text_button.dart';
import 'package:vhack_client/presentation/components/card/user_avatar_card.dart';
import 'package:vhack_client/presentation/screen/util/integration/crop_vision_screen.dart';
import 'package:vhack_client/presentation/screen/util/integration/paddyx_screen.dart';
import 'package:vhack_client/presentation/screen/util/integration/tutorial_screen.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';
import 'package:vhack_client/shared/constant/custom_string.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';

class UserDetailScreen extends StatelessWidget {
  final Map<String, dynamic> eachUser;
  const UserDetailScreen({super.key, required this.eachUser});

  final double coverHeight = 200;
  final double profileHeight = 200;

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: CustomColor.getBackgroundColor(context),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [buildTop(), buildContent(context)],
      ));

  Widget buildTop() {
    final top = coverHeight - profileHeight / 3;
    final bottom = profileHeight / 4;
    return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: bottom),
              child: buildCoverImage()),
          buildUserAvatar(top)
        ]);
  }

  Widget buildCoverImage() => Image.asset(
        'assets/userprofilewallpaper.jpg',
        width: double.infinity,
        height: coverHeight,
        fit: BoxFit.cover,
      );

  Widget buildUserAvatar(double top) => Positioned(
      top: top,
      child: UserAvatarCard(
          userAvatar: eachUser['userAvatar'], radius: profileHeight / 2));

  Widget buildContent(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTopContent(context),
          const SizedBox(
            height: 16,
          ),
          buildRowSocialIcon(context),
          const SizedBox(
            height: 16,
          ),
          const Divider(
            thickness: 0.5,
            color: Colors.grey,
          ),
          buildRowAboutWidget(context),
          const Divider(
            thickness: 0.5,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 16,
          ),
          buildCompanyName(context),
          const SizedBox(
            height: 16,
          ),
          buildCompanyDescription(context),
          const SizedBox(
            height: 16,
          ),
          buildCompanyOperaingHours(context)
        ],
      );

  Widget buildTopContent(BuildContext context) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              eachUser['userName'],
              style: CustomTextStyle.getTitleStyle(
                  context, 18, CustomColor.getTertieryColor(context)),
            ),
            Text(
              eachUser['userJobType'],
              style: CustomTextStyle.getTitleStyle(
                  context, 15, CustomColor.getSecondaryColor(context)),
            ),
          ],
        ),
      );

  Widget buildRowSocialIcon(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildSocialIcon(context, FontAwesomeIcons.instagram),
          const SizedBox(
            width: 16,
          ),
          buildSocialIcon(context, FontAwesomeIcons.facebook),
          const SizedBox(
            width: 16,
          ),
          buildSocialIcon(context, FontAwesomeIcons.whatsapp),
          const SizedBox(
            width: 16,
          ),
          buildSocialIcon(context, FontAwesomeIcons.tiktok),
        ],
      );

  Widget buildSocialIcon(BuildContext context, IconData iconData) =>
      CircleAvatar(
        backgroundColor: CustomColor.getSecondaryColor(context),
        radius: 25,
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Center(
              child: FaIcon(
                iconData,
                size: 24,
                color: CustomColor.getWhiteColor(context),
              ),
            ),
          ),
        ),
      );

  Widget buildRowAboutWidget(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildAboutWidget(context, title: 'Age', desc: eachUser['userAge']),
            const SizedBox(
              width: 32,
            ),
            Container(
              width: 1,
              height: 50,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 32,
            ),
            buildAboutWidget(context,
                title: 'Experience', desc: eachUser['userExperience'])
          ],
        ),
      );

  Widget buildAboutWidget(BuildContext context,
          {required String title, required String desc}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: CustomTextStyle.getTitleStyle(
                context, 15, CustomColor.getSecondaryColor(context)),
          ),
          Text(
            desc,
            style: CustomTextStyle.getTitleStyle(
                context, 15, CustomColor.getTertieryColor(context)),
          ),
        ],
      );

  Widget buildCompanyName(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Company Name',
              style: CustomTextStyle.getTitleStyle(
                  context, 15, CustomColor.getTertieryColor(context)),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              eachUser['userCompanyName'],
              style: CustomTextStyle.getSubTitleStyle(
                  context, 15, CustomColor.getTertieryColor(context)),
            )
          ],
        ),
      );

  Widget buildCompanyDescription(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Company Description',
              style: CustomTextStyle.getTitleStyle(
                  context, 15, CustomColor.getTertieryColor(context)),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              eachUser['userDescription'],
              style: CustomTextStyle.getSubTitleStyle(
                  context, 15, CustomColor.getTertieryColor(context)),
            )
          ],
        ),
      );

  Widget buildCompanyOperaingHours(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Operating Hours',
              style: CustomTextStyle.getTitleStyle(
                  context, 15, CustomColor.getTertieryColor(context)),
            ),
            buildListHour(context)
          ],
        ),
      );

  Widget buildListHour(BuildContext context) {
    final listOperating = eachUser['userOperatingHours'];
    if (listOperating.isEmpty) {
      return Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Text(
            'Always Open',
            style: CustomTextStyle.getSubTitleStyle(
                context, 15, CustomColor.getTertieryColor(context)),
          ),
        ],
      );
    } else {
      return Column(
        children: List.generate(eachUser['userOperatingHours'].length, (index) {
          List<Map<String, dynamic>> listOperating =
              eachUser['userOperatingHours'];
          return ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                listOperating[index]['operatingDay'],
                style: CustomTextStyle.getSubTitleStyle(
                    context, 15, CustomColor.getTertieryColor(context)),
              ),
              trailing: Text(
                listOperating[index]['operatingHour'],
                style: CustomTextStyle.getTitleStyle(
                    context, 15, CustomColor.getTertieryColor(context)),
              ));
        }),
      );
    }
  }
}
