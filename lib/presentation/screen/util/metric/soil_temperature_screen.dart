import 'package:flutter/material.dart';
import 'package:vhack_client/presentation/components/chart/my_progress_bar.dart';

import '../../../../shared/constant/custom_color.dart';
import '../../../../shared/constant/custom_textstyle.dart';
import '../../../components/chart/line_chart.dart';

class SoilTemperatureScreen extends StatefulWidget {
  const SoilTemperatureScreen({super.key});

  @override
  State<SoilTemperatureScreen> createState() => _SoilTemperatureScreenState();
}

class _SoilTemperatureScreenState extends State<SoilTemperatureScreen> {
  List<Map<String, dynamic>> listPhase = [
    {
      'phaseID': '1',
      'phaseTitle': 'Seeding',
      'phaseTemp': '20-30 C',
      'phaseLosses': 'Seeds may fail to germinate or germinate slowly',
      'phaseAt': 'Range 1-2 Weeks',
      'phaseStatus': true
    },
    {
      'phaseID': '2',
      'phaseTitle': 'Vegetative Growth',
      'phaseTemp': '25-35 C',
      'phaseLosses':
          'Heat stress, resulting in reduced tilltering and leaf wilting',
      'phaseAt': 'Range 1-2 Weeks',
      'phaseStatus': false
    },
    {
      'phaseID': '3',
      'phaseTitle': 'Reproductive Stage',
      'phaseTemp': '25-30 C',
      'phaseLosses':
          'Poor pollination and spikelet sterility, leading to reduced grain set and yield',
      'phaseAt': 'Range 1-2 Months',
      'phaseStatus': false
    },
    {
      'phaseID': '4',
      'phaseTitle': 'Grain Filling Stage',
      'phaseTemp': '25-30 C',
      'phaseLosses':
          'Spikelet sterility, poor grain filling, and reduced yield',
      'phaseAt': 'Range 1-2 Months',
      'phaseStatus': false
    },
    {
      'phaseID': '5',
      'phaseTitle': 'Harvesting',
      'phaseTemp': '> 20 c',
      'phaseLosses':
          'Delay maturation and increase the risk of disease like fungal infections',
      'phaseAt': 'Range 1',
      'phaseStatus': false
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColor.getBackgroundColor(context),
        appBar: buildAppBar(context),
        body: CustomScrollView(
          slivers: [
            buildHeader(),
            buildSizeBox(),
            buildGraph(),
            buildSizeBox(),
            buildOperationActivity(context, false),
            buildSizeBox(),
            buildOperationActivity(context, true),
            buildSizeBox()
          ],
        ));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColor.getSecondaryColor(context),
      elevation: 0.5,
      centerTitle: true,
      title: Text(
        'Soil Temperature',
        style: CustomTextStyle.getTitleStyle(
            context, 18, CustomColor.getWhiteColor(context)),
      ),
    );
  }

  Widget buildHeader() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Track your soil temperature',
              style: CustomTextStyle.getTitleStyle(
                  context, 15, CustomColor.getTertieryColor(context)),
            ),
            Text(
              'Your recent activity is below.',
              style: CustomTextStyle.getSubTitleStyle(
                  context, 12, CustomColor.getTertieryColor(context)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGraph() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: CustomColor.getPrimaryColor(context),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey, width: 0.5)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    color: CustomColor.getSecondaryColor(context),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Soil Temperature Meter',
                    style: CustomTextStyle.getTitleStyle(
                        context, 12, CustomColor.getTertieryColor(context)),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const MyProgressBar(
                      radius: 200, lineWidth: 30, percentage: 19.0)),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildStatusCard(title: 'Low', color: Colors.green),
                  buildStatusCard(
                      title: 'Medium', color: Colors.yellow.shade700),
                  buildStatusCard(title: 'High', color: Colors.red)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOperationActivity(BuildContext context, bool isPhases) {
    if (!isPhases) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Operation',
                style: CustomTextStyle.getTitleStyle(
                    context, 18, CustomColor.getTertieryColor(context)),
              ),
              Text(
                'Measuring Temperature',
                style: CustomTextStyle.getSubTitleStyle(
                    context, 12, CustomColor.getTertieryColor(context)),
              ),
            ],
          ),
        ),
      );
    } else {
      return SliverList.builder(
        itemCount: listPhase.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: buildSoilCard(context, listPhase[index]),
          );
        },
      );
    }
  }

  Widget buildSoilCard(BuildContext context, Map<String, dynamic> eachPhase) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: CustomColor.getPrimaryColor(context)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 15,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12)),
                color: CustomColor.getSecondaryColor(context)),
          ),
          Expanded(
            child: ListTile(
              title: Text(
                eachPhase['phaseTitle'],
                style: CustomTextStyle.getTitleStyle(
                    context, 15, CustomColor.getTertieryColor(context)),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Desired Temperature: ${eachPhase['phaseTemp']}',
                        style: CustomTextStyle.getSubTitleStyle(
                            context, 12, CustomColor.getTertieryColor(context)),
                      ),
                      Text(
                        'Primary Losses: ${eachPhase['phaseLosses']}',
                        style: CustomTextStyle.getSubTitleStyle(
                            context, 12, CustomColor.getTertieryColor(context)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    ' ${eachPhase['phaseAt']}',
                    style:
                        CustomTextStyle.getTitleStyle(context, 12, Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStatusCard({required String title, required Color color}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          title,
          style: CustomTextStyle.getTitleStyle(
              context, 12, CustomColor.getTertieryColor(context)),
        )
      ],
    );
  }

  Widget buildSizeBox() {
    return const SliverToBoxAdapter(
      child: SizedBox(height: 10),
    );
  }
}
