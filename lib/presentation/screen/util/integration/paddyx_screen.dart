import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:vhack_client/presentation/components/button/text_button.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';

import '../../../../shared/constant/custom_textstyle.dart';

class PaddyXScreen extends StatelessWidget {
  PaddyXScreen({super.key});

  List<Map<String, dynamic>> listSensor = [
    {
      'deviceName': 'Device 1',
      'deviceStatus': true,
      'fieldName': 'Field 1',
      'deviceGroup': 'Moisture'
    },
    {
      'deviceName': 'Device 2',
      'deviceStatus': true,
      'fieldName': 'Field 2',
      'deviceGroup': 'Moisture'
    },
    {
      'deviceName': 'Device 1',
      'deviceStatus': true,
      'fieldName': 'Field 3',
      'deviceGroup': 'Temperature'
    },
    {
      'deviceName': 'Device 2',
      'deviceStatus': false,
      'fieldName': 'Field 4',
      'deviceGroup': 'Temperature'
    },
    {
      'deviceName': 'Device 1',
      'deviceStatus': true,
      'fieldName': 'Field 1',
      'deviceGroup': 'Pest Detector'
    },
    {
      'deviceName': 'Device 2',
      'deviceStatus': false,
      'fieldName': 'Field 2',
      'deviceGroup': 'Pest Detector'
    }
  ];

  List<Map<String, dynamic>> features = [
    {'title': 'Real-Time Monitoring', 'icon': Icons.history},
    {'title': 'Precision Irrigation', 'icon': Icons.area_chart},
    {'title': 'Predictive Insights', 'icon': Icons.remove_red_eye},
    {'title': 'Enhanced Yield and Efficiency', 'icon': Icons.fast_forward}
  ];

  String selectedAsset(String deviceGroup) {
    final Map<String, dynamic> asset = {
      'Moisture': 'assets/Humidity1.svg',
      'Temperature': 'assets/Temperature.svg',
      'Pest Detector': 'assets/feature/Pest icon.svg',
    };

    final String? chooseAsset = asset[deviceGroup];
    if (chooseAsset != null) {
      return chooseAsset;
    }
    return 'assets/Humidity.svg';
  }

  String description =
      'Integrate CropX technology into your application to revolutionize your farming practices. Install sensors on your fields to measure soil moisture, temperature, and other crucial environmental factors in real-time. With CropX, you can make data-driven decisions, optimize irrigation schedules, and maximize crop yield like never before.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColor.getBackgroundColor(context),
        appBar: buildAppBar(context),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: buildHeader(context),
            ),
            buildSpacer(20),
            SliverToBoxAdapter(
              child: buildListSensor(context),
            ),
            buildSpacer(20),
            SliverToBoxAdapter(
              child: buildTitle(context),
            ),
            buildSpacer(20),
            buildList(),
            buildSpacer(20),
            SliverToBoxAdapter(
              child: buildButton(),
            )
          ],
        ));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColor.getSecondaryColor(context),
      centerTitle: true,
      title: Text(
        'PaddyX',
        style: CustomTextStyle.getTitleStyle(
            context, 18, CustomColor.getWhiteColor(context)),
      ),
      automaticallyImplyLeading: true,
    );
  }

  Widget buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Number of Sensors',
                style: CustomTextStyle.getTitleStyle(
                    context, 18, CustomColor.getTertieryColor(context)),
              ),
              SvgPicture.asset(
                'assets/PaddyX.svg',
                height: 40,
                width: 40,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildHeaderCard(context, 'Temp', 2),
              const SizedBox(
                width: 10,
              ),
              buildHeaderCard(context, 'Pest Detector', 3),
              const SizedBox(
                width: 10,
              ),
              buildHeaderCard(context, 'Moisture', 2)
            ],
          ),
        ],
      ),
    );
  }

  Widget buildHeaderCard(BuildContext context, String title, int value) {
    return Expanded(
      child: Container(
        height: 120,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey, width: 0.5),
            color: CustomColor.getPrimaryColor(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: CustomTextStyle.getSubTitleStyle(
                  context, 15, CustomColor.getTertieryColor(context)),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              value.toString(),
              style: CustomTextStyle.getTitleStyle(
                  context, 32, CustomColor.getSecondaryColor(context)),
            )
          ],
        ),
      ),
    );
  }

  Widget buildListSensor(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GroupedListView(
        reverse: false,
        shrinkWrap: true,
        order: GroupedListOrder.DESC,
        elements: listSensor,
        groupBy: (element) {
          return element['deviceGroup'];
        },
        groupHeaderBuilder: (sensor) {
          return Text(
            sensor['deviceGroup'],
            style: CustomTextStyle.getTitleStyle(
                context, 15, CustomColor.getTertieryColor(context)),
          );
        },
        indexedItemBuilder: (context, sensor, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: buildSensorCard(context, sensor),
          );
        },
      ),
    );
  }

  Widget buildSensorCard(BuildContext context, final sensor) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey, width: 0.5),
        color: CustomColor.getPrimaryColor(context),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: SvgPicture.asset(
          selectedAsset(sensor['deviceGroup']),
          height: 40,
          width: 40,
        ),
        title: Text(
          sensor['deviceName'],
          style: CustomTextStyle.getTitleStyle(
              context, 15, CustomColor.getTertieryColor(context)),
        ),
        subtitle: Text(
          sensor['fieldName'],
          style: CustomTextStyle.getSubTitleStyle(
              context, 12, CustomColor.getTertieryColor(context)),
        ),
        trailing: Text(
          sensor['fieldName'],
          style: CustomTextStyle.getTitleStyle(
              context, 15, CustomColor.getTertieryColor(context)),
        ),
      ),
    );
  }

  Widget buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Paddy X Integration',
            style: CustomTextStyle.getTitleStyle(
                context, 18, CustomColor.getTertieryColor(context)),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            description,
            style: CustomTextStyle.getSubTitleStyle(
                context, 12, CustomColor.getTertieryColor(context)),
          )
        ],
      ),
    );
  }

  Widget buildList() {
    return SliverList.builder(
      itemCount: features.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: buildCard(
              context, features[index]['title'], features[index]['icon']),
        );
      },
    );
  }

  Widget buildCard(BuildContext context, String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: CustomColor.getPrimaryColor(context),
          border: Border.all(color: Colors.grey, width: 0.5)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: CustomColor.getSecondaryColor(context),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: CustomTextStyle.getTitleStyle(
                context, 12, CustomColor.getTertieryColor(context)),
          )
        ],
      ),
    );
  }

  Widget buildButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
      child: TextOnlyButton(
          buttonTitle: 'Buy Sensors',
          onPressed: () {},
          isMain: true,
          borderRadius: 12),
    );
  }

  Widget buildSpacer(double value) {
    return SliverToBoxAdapter(
      child: SizedBox(height: value),
    );
  }
}
