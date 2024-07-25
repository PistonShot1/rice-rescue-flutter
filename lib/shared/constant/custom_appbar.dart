import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';

import 'custom_color.dart';

class CustomAppBar {
  static AppBar BuildMainAppBar(BuildContext context, bool isBuildScreen) {
    return (AppBar(
        backgroundColor: CustomColor.getBackgroundColor(context),
        elevation: 0.5,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: buildTitle(context, isBuildScreen)));
  }

  static Widget buildTitle(BuildContext context, bool isBuildScreen) {
    if (isBuildScreen) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildAssetImage(context),
          Text('Rice Rescue',
              style: CustomTextStyle.getTitleStyle(
                context,
                15,
                CustomColor.getSecondaryColor(context),
              )),
        ],
      );
    } else {
      return Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              color: CustomColor.getSecondaryColor(context),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildAssetImage(context),
                Text('Rise Rescue',
                    style: CustomTextStyle.getTitleStyle(
                      context,
                      15,
                      CustomColor.getSecondaryColor(context),
                    )),
              ],
            ),
          )
        ],
      );
    }
  }

  static Widget buildAssetImage(BuildContext context) => ClipRRect(
        child: Image.asset(
          'assets/logo.png',
          height: 60,
          width: 60,
          fit: BoxFit.cover,
        ),
      );
}
