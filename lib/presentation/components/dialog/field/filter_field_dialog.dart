import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vhack_client/controller/provider/field/type_field_provider.dart';

import '../../../../shared/constant/custom_color.dart';
import '../../../../shared/constant/custom_textstyle.dart';

class FilterFieldDialog extends StatelessWidget {
  const FilterFieldDialog({
    super.key,
  });

  void _selectedFilter(BuildContext context, Map<String, dynamic> filter) {
    Provider.of<TypeFieldProvider>(context, listen: false).selectType(filter);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TypeFieldProvider>(
      builder: (context, value, child) {
        return buildContent(context, value.listFilter);
      },
    );
  }

  Widget buildContent(
      BuildContext context, List<Map<String, dynamic>> listFilter) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: buildTitle(context)),
        const SizedBox(
          height: 10,
        ),
        buildCategory(context, listFilter)
      ],
    );
  }

  Widget buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, top: 10),
      child: Column(
        children: [
          buildTopChip(),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Filters',
            style: CustomTextStyle.getTitleStyle(
                context, 18, CustomColor.getTertieryColor(context)),
          ),
        ],
      ),
    );
  }

  Widget buildCategory(
      BuildContext context, List<Map<String, dynamic>> listFilter) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Category Area',
            style: CustomTextStyle.getTitleStyle(
                context, 15, CustomColor.getTertieryColor(context)),
          ),
          const SizedBox(
            height: 10,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: listFilter.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: buildCategoryCard(context, listFilter[index]),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildCategoryCard(
      BuildContext context, Map<String, dynamic> eachFilter) {
    return InkWell(
      onTap: () {
        _selectedFilter(context, eachFilter);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: CustomColor.getPrimaryColor(context),
            border: Border.all(color: Colors.grey, width: 0.5)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: eachFilter['filterColor']),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              eachFilter['filterTitle'],
              style: CustomTextStyle.getTitleStyle(
                  context, 15, CustomColor.getTertieryColor(context)),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTopChip() {
    return Container(
      width: 50,
      height: 5,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(32)),
    );
  }
}
