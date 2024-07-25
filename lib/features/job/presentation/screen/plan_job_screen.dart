import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vhack_client/features/auth/domain/entity/user_entity.dart';
import 'package:vhack_client/presentation/components/button/icon_button.dart';
import 'package:vhack_client/presentation/components/button/small_button.dart';
import 'package:vhack_client/features/job/presentation/screen/create_task_screen.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';

class PlanJobScreen extends StatelessWidget {
  final UserEntity userEntity;
  PlanJobScreen({super.key, required this.userEntity});

  final List<Map<String, dynamic>> listPlanJobStarting = [
    {
      'planTitle': 'Spray',
      'planIcon': 'assets/job/spray.svg',
      'planColor': Colors.orange.shade100
    },
    {
      'planTitle': 'Fertilize',
      'planIcon': 'assets/job/fertilizer.svg',
      'planColor': Colors.green.shade100
    },
    {
      'planTitle': 'Harvest',
      'planIcon': 'assets/job/harvest.svg',
      'planColor': Colors.red.shade100
    },
    {
      'planTitle': 'Irrigate',
      'planIcon': 'assets/job/irrigation.svg',
      'planColor': Colors.blue.shade100
    },
    {
      'planTitle': 'Seedling',
      'planIcon': 'assets/job/seeding.svg',
      'planColor': Colors.pink.shade100
    },
    {
      'planTitle': 'Custom',
      'planIcon': 'assets/job/custom.svg',
      'planColor': Colors.grey.shade300
    }
  ];

  final List<Map<String, dynamic>> listPlanJobExp = [
    {
      'planTitle': 'Soil Preparation',
      'planIcon': 'assets/job/exp/soilpreparation.svg',
    },
    {
      'planTitle': 'Seed Treament',
      'planIcon': 'assets/job/exp/seddlingtreatement.svg',
    },
    {
      'planTitle': 'Delivery / Logistic',
      'planIcon': 'assets/job/exp/seddlingtreatement.svg',
    },
    {
      'planTitle': 'Sampling',
      'planIcon': 'assets/job/exp/sampling.svg',
    },
    {
      'planTitle': 'Field Report',
      'planIcon': 'assets/job/exp/fieldreport.svg',
    },
    {
      'planTitle': 'Trial',
      'planIcon': 'assets/job/exp/trial.svg',
    },
    {
      'planTitle': 'Finance',
      'planIcon': 'assets/job/exp/FinanceTask.svg',
    }
  ];

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
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SmallButton(
                      buttonTitle: 'Just Starting',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            buildListPlanJobStarting(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SmallButton(
                      buttonTitle: 'Experienced',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            buildListPlanJobExp()
          ],
        ));
  }

  AppBar buildAppBar(BuildContext context) => AppBar(
        backgroundColor: CustomColor.getSecondaryColor(context),
        elevation: 0.5,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text(
          'Plan Job',
          style: CustomTextStyle.getTitleStyle(
              context, 18, CustomColor.getWhiteColor(context)),
        ),
      );

  Widget buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Job Type',
            style: CustomTextStyle.getTitleStyle(
                context, 21, CustomColor.getTertieryColor(context)),
          ),
          Text(
            'Choose one job you like',
            style: CustomTextStyle.getSubTitleStyle(
                context, 15, CustomColor.getTertieryColor(context)),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget buildListPlanJobStarting() {
    return SliverGrid.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: listPlanJobStarting.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                buildPlanJobStartingCard(context, listPlanJobStarting[index]));
      },
    );
  }

  Widget buildPlanJobStartingCard(
      BuildContext context, final eachPlanJobStaring) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CreateTaskScreen(
            userEntity: userEntity,
            jobType: eachPlanJobStaring['planTitle'],
          ),
        ));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: CustomColor.getPrimaryColor(context),
            border: Border.all(color: Colors.grey, width: 0.5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: eachPlanJobStaring['planColor']),
              child: SvgPicture.asset(
                eachPlanJobStaring['planIcon'],
                semanticsLabel: 'Acme Logo',
                height: 40,
                width: 40,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              eachPlanJobStaring['planTitle'],
              style: CustomTextStyle.getTitleStyle(
                  context, 15, CustomColor.getTertieryColor(context)),
            )
          ],
        ),
      ),
    );
  }

  Widget buildListPlanJobExp() {
    return SliverList.builder(
      itemCount: listPlanJobExp.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> eachplanJobExp = listPlanJobExp[index];
        return buildPlanJobExpCard(context, eachplanJobExp);
      },
    );
  }

  Widget buildPlanJobExpCard(
      BuildContext context, Map<String, dynamic> eachplanJobExp) {
    return ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CreateTaskScreen(
              userEntity: userEntity,
              jobType: eachplanJobExp['planTitle'],
            ),
          ));
        },
        leading: SvgPicture.asset(
          eachplanJobExp['planIcon'],
          semanticsLabel: 'Acme Logo',
          height: 40,
          width: 40,
        ),
        title: Text(
          eachplanJobExp['planTitle'],
          style: CustomTextStyle.getTitleStyle(
              context, 15, CustomColor.getTertieryColor(context)),
        ),
        trailing: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_forward_ios,
            )));
  }
}
