import 'package:flutter/material.dart';
import 'package:vhack_client/presentation/components/chart/line_chart.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';

class FertilizationScreen extends StatefulWidget {
  FertilizationScreen({super.key});

  @override
  State<FertilizationScreen> createState() => _FertilizationScreenState();
}

class _FertilizationScreenState extends State<FertilizationScreen> {
  bool isSelected = false;

  List<Map<String, dynamic>> listPhase = [
    {
      'phaseID': '1',
      'phaseTitle': '1st Phase',
      'phaseAt': 'You Start today at 5:30 p.m.',
      'phaseStatus': true
    },
    {
      'phaseID': '2',
      'phaseTitle': '2nd Phase',
      'phaseAt': 'You Start today at 5:30 p.m.',
      'phaseStatus': false
    },
    {
      'phaseID': '3',
      'phaseTitle': '3rd Phase',
      'phaseAt': 'You Start today at 5:30 p.m.',
      'phaseStatus': false
    },
    {
      'phaseID': '4',
      'phaseTitle': '4th Phase',
      'phaseAt': 'You Start today at 5:30 p.m.',
      'phaseStatus': false
    }
  ];

  Color selectedColor(String phaseID) {
    final Map<String, Color> phaseColor = {
      '1': Colors.black38,
      '2': Colors.orange,
      '3': Colors.yellow,
      '4': CustomColor.getSecondaryColor(context)
    };

    final Color? color = phaseColor[phaseID];
    if (color != null) {
      return color;
    }
    return Colors.black;
  }

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
            buildPhaseActivity(context, false),
            buildSizeBox(),
            buildPhaseActivity(context, true),
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
        'Fertilization Phase',
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
              'Track your fertilization phase',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
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
                        'Fertilization Phase for Transplanter Method',
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
                      child: LineChartSample2())
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPhaseActivity(BuildContext context, bool isPhases) {
    if (!isPhases) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Phase Activity',
                style: CustomTextStyle.getTitleStyle(
                    context, 18, CustomColor.getTertieryColor(context)),
              ),
              Text(
                'Checklist for your fertilization phases',
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
            child: buildFertilizationCard(context, listPhase[index]),
          );
        },
      );
    }
  }

  Widget buildFertilizationCard(
      BuildContext context, Map<String, dynamic> eachPhase) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: CustomColor.getPrimaryColor(context)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 15,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12)),
                color: selectedColor(eachPhase['phaseID'])),
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
                        'Growth Stage: Vegetative (3 Leaves)',
                        style: CustomTextStyle.getSubTitleStyle(
                            context, 12, CustomColor.getTertieryColor(context)),
                      ),
                      Text(
                        'Fertilizer Type: Compound Fertilizer',
                        style: CustomTextStyle.getSubTitleStyle(
                            context, 12, CustomColor.getTertieryColor(context)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'You start today at 5:30 p.m.',
                    style:
                        CustomTextStyle.getTitleStyle(context, 12, Colors.grey),
                  ),
                ],
              ),
              trailing: Checkbox(
                checkColor: CustomColor.getWhiteColor(context),
                activeColor: CustomColor.getSecondaryColor(context),
                side: BorderSide(
                    color: CustomColor.getSecondaryColor(context), width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                value: eachPhase['phaseStatus'],
                onChanged: (value) {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSizeBox() {
    return const SliverToBoxAdapter(
      child: SizedBox(height: 10),
    );
  }
}
