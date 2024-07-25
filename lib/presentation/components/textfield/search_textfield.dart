import 'package:flutter/material.dart';

import '../../../shared/constant/custom_color.dart';
import '../../../shared/constant/custom_textstyle.dart';

class SearchTextfield extends StatelessWidget {
  final String title;
  final TextEditingController tcSearch;
  final Function(String)? onChanged;
  const SearchTextfield(
      {super.key,
      required this.title,
      required this.tcSearch,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return buildSearchTextfield(context);
  }

  Widget buildSearchTextfield(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: CustomColor.getPrimaryColor(context)),
      child: TextField(
          controller: tcSearch,
          keyboardType: TextInputType.name,
          cursorColor: CustomColor.getSecondaryColor(context),
          onChanged: onChanged,
          style: CustomTextStyle.getSubTitleStyle(
              context, 15, CustomColor.getTertieryColor(context)),
          decoration: InputDecoration(
              hintText: title,
              hintStyle: CustomTextStyle.getSubTitleStyle(
                  context, 12, CustomColor.getTertieryColor(context)),
              prefixIcon: Icon(
                Icons.search,
                color: CustomColor.getSecondaryColor(context),
              ),
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none)),
    );
  }
}
