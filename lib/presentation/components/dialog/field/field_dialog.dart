import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:vhack_client/features/field/domain/entity/field_entity.dart';
import 'package:vhack_client/presentation/components/chart/my_line_chart.dart';
import 'package:vhack_client/presentation/components/chart/soil_moist_chart.dart';
import 'package:vhack_client/presentation/components/chart/soil_temp_chart.dart';

import '../../../../shared/constant/custom_color.dart';
import '../../../../shared/constant/custom_string.dart';
import '../../../../shared/constant/custom_textstyle.dart';
import '../../chart/line_chart.dart';
import '../../image/mynetwork_image.dart';

class FieldDialog extends StatelessWidget {
  final FieldEntity fieldEntity;
  FieldDialog({super.key, required this.fieldEntity});

  double convertTemp(double value) {
    if (value > 60 || value == 60) {
      return 60;
    }
    return value / 10;
  }

  List<FlSpot> listSoilTemp = [
    FlSpot(0, 46 / 10),
    FlSpot(1, 2),
    FlSpot(2, 4),
    FlSpot(3, 2.4),
    FlSpot(4, 2.1),
    FlSpot(5, 1.9),
    FlSpot(6, 3.1),
    FlSpot(7, 2.75),
    FlSpot(8, 2.4),
    FlSpot(9, 4),
    FlSpot(10, 2.9),
    FlSpot(11, 1.5),
  ];

  List<FlSpot> listSoilMoisture = [
    FlSpot(0, 2),
    FlSpot(1, 2),
    FlSpot(2, 2.5),
    FlSpot(3, 2.2),
    FlSpot(4, 2.1),
    FlSpot(5, 1.9),
    FlSpot(6, 2.7),
    FlSpot(7, 2.4),
    FlSpot(8, 2.4),
    FlSpot(9, 2.2),
    FlSpot(10, 2.1),
    FlSpot(11, 1.9),
  ];

  @override
  Widget build(BuildContext context) {
    return buildContentField(context);
  }

  Widget buildContentField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildPaddyCrop(context),
          const SizedBox(
            height: 10,
          ),
          buildSoilTemperature(context),
          const SizedBox(
            height: 20,
          ),
          buildSoilMoisture(context),
        ],
      ),
    );
  }

  Widget buildPaddyCrop(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              fieldEntity.fieldName!,
              style: CustomTextStyle.getTitleStyle(
                  context, 15, CustomColor.getTertieryColor(context)),
            ),
            subtitle: Text(
              fieldEntity.fieldCA!,
              style: CustomTextStyle.getTitleStyle(
                  context, 12, CustomColor.getSecondaryColor(context)),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNutrientStatus(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nutrient Status',
            style: CustomTextStyle.getTitleStyle(
                context, 15, CustomColor.getTertieryColor(context)),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: Colors.grey)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildNutrientText(
                    '1st Phase', CustomColor.getFirstPhaseColor(), context),
                buildNutrientChip(),
                buildNutrientText(
                    '2nd Phase', CustomColor.getSecondPhaseColor(), context),
                buildNutrientChip(),
                buildNutrientText(
                    '3rd Phase', CustomColor.getThirdPhaseColor(), context),
                buildNutrientChip(),
                buildNutrientText(
                    '4th Phase', CustomColor.getFourthPhaseColor(), context),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildNutrientText(
      String nutrientTitle, Color nutrientColor, BuildContext context) {
    return Text(
      nutrientTitle,
      style: CustomTextStyle.getTitleStyle(context, 12, nutrientColor),
    );
  }

  Widget buildSoilTemperature(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Soil Temperature',
            style: CustomTextStyle.getTitleStyle(
                context, 15, CustomColor.getTertieryColor(context)),
          ),
          const SizedBox(
            height: 5,
          ),
          SoilTempChart(fieldEntity: fieldEntity)
        ],
      ),
    );
  }

  Widget buildSoilMoisture(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Soil Moisture',
            style: CustomTextStyle.getTitleStyle(
                context, 15, CustomColor.getTertieryColor(context)),
          ),
          const SizedBox(
            height: 5,
          ),
          SoilMoistChart(fieldEntity: fieldEntity)
        ],
      ),
    );
  }

  Widget buildDiseaseRisk(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Disease Risk',
            style: CustomTextStyle.getTitleStyle(
                context, 15, CustomColor.getTertieryColor(context)),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 30,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: CustomColor.getSecondaryColor(context)),
                    child: Center(
                      child: Text(
                        'Bacterial',
                        style: CustomTextStyle.getSubTitleStyle(
                            context, 12, CustomColor.getWhiteColor(context)),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildBottomChip() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
          child: Container(
            width: 48,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildNutrientChip() {
    return Container(
      width: 1,
      height: 25,
      decoration: const BoxDecoration(
        color: Colors.grey,
      ),
    );
  }

  Widget buildTest(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Paddy Crop',
          style: CustomTextStyle.getTitleStyle(
              context, 15, CustomColor.getTertieryColor(context)),
        ),
        TextButton.icon(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            ),
            backgroundColor: MaterialStateProperty.all(
              CustomColor.getSecondaryColor(context),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          onPressed: () {},
          icon: const Icon(
            Icons.group,
            color: Colors.white,
          ),
          label: Text(
            'Team',
            style: CustomTextStyle.getTitleStyle(
              context,
              12,
              CustomColor.getWhiteColor(context),
            ),
          ),
        )
      ],
    );
  }
}
