import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:vhack_client/features/auth/domain/entity/user_entity.dart';
import 'package:vhack_client/presentation/components/image/mynetwork_image.dart';
import 'package:vhack_client/presentation/components/timeline/timeline_tuto.dart';
import 'package:vhack_client/presentation/screen/bridge_screen.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';

import '../../../../features/auth/presentation/cubit/auth/auth_cubit.dart';
import '../../../../features/auth/presentation/cubit/credential/credential_cubit.dart';
import '../../../../shared/constant/custom_string.dart';
import '../../../../features/field/presentation/screen/first_field_screen.dart';

class TutorailScreen extends StatefulWidget {
  final bool isFromWelcomeExp;
  final String userID;
  const TutorailScreen(
      {super.key, required this.isFromWelcomeExp, required this.userID});

  @override
  State<TutorailScreen> createState() => _TutorailScreenState();
}

class _TutorailScreenState extends State<TutorailScreen> {
  final scrollController = ScrollController();
  final pageController = PageController();
  int currentIndex = 1;

  List<Map<String, dynamic>> tutorialss = [
    {
      'tutorialTitle': CustomString.soilPreparation,
      'tutorialGroup': 'Soil Preparation',
    },
    {
      'tutorialTitle': CustomString.seedSelection,
      'tutorialGroup': 'Seed Selection'
    },
    {
      'tutorialTitle': CustomString.seedPreparation,
      'tutorialGroup': 'Seed Preparation'
    },
    {'tutorialTitle': CustomString.irrigation, 'tutorialGroup': 'Irrigation'},
    {
      'tutorialTitle': CustomString.soilTemperatureMonitoring,
      'tutorialGroup': 'Soil Temperature Monitoring'
    },
    {'tutorialTitle': CustomString.fertilizing, 'tutorialGroup': 'Fertilizing'},
    {
      'tutorialTitle': CustomString.monitoringPaddy,
      'tutorialGroup': 'Monitoring Paddy'
    },
    {
      'tutorialTitle': CustomString.pestDiseaseManagement,
      'tutorialGroup': 'Pest and Disease Management'
    },
    {'tutorialTitle': CustomString.harvesting, 'tutorialGroup': 'Harvesting'},
  ];

  List<Map<String, dynamic>> listTuto = [
    {
      'tutorialTitle': 'Soil Preparation',
      'tutorialDesc': CustomString.soilPreparation,
      'tutorialGroup': 'Soil & Seed',
      'tutorialImage': 'assets/integration/tutorial/soil.png'
    },
    {
      'tutorialTitle': 'Seed Selection',
      'tutorialDesc': CustomString.seedSelection,
      'tutorialGroup': 'Soil & Seed',
      'tutorialImage': 'assets/integration/tutorial/seed.png'
    },
    {
      'tutorialTitle': 'Irrigation',
      'tutorialDesc': CustomString.irrigation,
      'tutorialGroup': 'Irrigation',
      'tutorialImage': 'assets/integration/tutorial/irrigation.png'
    },
    {
      'tutorialTitle': 'Soil Temperature',
      'tutorialDesc':
          CustomString.soilTemperatureMonitoring.replaceAll('\n', ''),
      'tutorialGroup': 'Irrigation',
      'tutorialImage':
          'assets/integration/tutorial/soiltemp.png' // Provide the image path for soil temperature monitoring tutorial
    },
    {
      'tutorialTitle': 'Fertilizing',
      'tutorialDesc': CustomString.fertilizing,
      'tutorialGroup': 'Fertilize',
      'tutorialImage':
          'assets/integration/tutorial/fertilizing.png' // Provide the image path for fertilizing tutorial
    },
    {
      'tutorialTitle': 'Monitoring Paddy',
      'tutorialDesc': CustomString.monitoringPaddy,
      'tutorialGroup': 'Monitor',
      'tutorialImage':
          'assets/integration/tutorial/monitorpaddy.jpeg' // Provide the image path for monitoring paddy tutorial
    },
    {
      'tutorialTitle': 'Pest Monitoring',
      'tutorialDesc': CustomString.pestDiseaseManagement,
      'tutorialGroup': 'Monitor',
      'tutorialImage':
          'assets/integration/tutorial/monitorpest.png' // Provide the image path for pest and disease management tutorial
    },
    {
      'tutorialTitle': "Harvest",
      'tutorialDesc': CustomString.harvesting,
      'tutorialGroup': 'Harvest',
      'tutorialImage':
          'assets/integration/tutorial/harvest.jpg' // Provide the image path for harvesting tutorial
    },
  ];

  List<Map<String, dynamic>> listTutoTimeline = [
    {
      'tutorialGroup': 'Soil & Seed',
      'isPass': true,
    },
    {
      'tutorialGroup': 'Irrigation',
      'isPass': false,
    },
    {
      'tutorialGroup': 'Fertilize',
      'isPass': false,
    },
    {
      'tutorialGroup': 'Monitor',
      'isPass': false,
    },
    {
      'tutorialGroup': 'Harvest',
      'isPass': false,
    },
  ];

  void changeIndex() {
    setState(() {
      if (currentIndex > listTutoTimeline.length - 1) {
        scrollUp();
        resetPage();
        currentIndex = 1;
        listTutoTimeline.forEach((element) {
          element['isPass'] = false;
        });
        listTutoTimeline[0]['isPass'] = true;
      } else {
        listTutoTimeline[currentIndex]['isPass'] = true;
        if (currentIndex == 3) {
          scrollDown();
        }
        goToNextPage();
        currentIndex++;
      }
    });
  }

  void scrollUp() {
    double start = 0;
    scrollController.animateTo(start,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void scrollDown() {
    double end = scrollController.position.maxScrollExtent;
    scrollController.animateTo(end,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void goToNextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void resetPage() {
    pageController.jumpTo(0);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildContent();
  }

  Widget buildContent() => Scaffold(
        backgroundColor: CustomColor.getBackgroundColor(context),
        appBar: buildAppbar(context),
        floatingActionButton: buildFloatingActionButton(context),
        body: Column(
          children: [buildListTimeLine(), buildListPage()],
        ),
      );

  AppBar buildAppbar(BuildContext context) => AppBar(
        backgroundColor: CustomColor.getSecondaryColor(context),
        centerTitle: true,
        automaticallyImplyLeading: widget.isFromWelcomeExp ? false : true,
        title: Text(
          'Tutorial',
          style: CustomTextStyle.getTitleStyle(
              context, 18, CustomColor.getWhiteColor(context)),
        ),
        actions: [
          if (widget.isFromWelcomeExp)
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => FirstFieldScreen(
                          userID: widget.userID,
                        ),
                      ),
                      (route) => false);
                },
                icon: const Icon(Icons.skip_next_outlined))
        ],
      );

  FloatingActionButton buildFloatingActionButton(BuildContext context) =>
      FloatingActionButton(
        onPressed: () {
          changeIndex();
        },
        child: Icon(
          Icons.arrow_forward_ios,
          color: CustomColor.getWhiteColor(context),
        ),
      );

  Widget buildListTimeLine() => SizedBox(
        height: 150,
        child: ListView.builder(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: listTutoTimeline.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              return buildTimeLine(context,
                  isFirst: true,
                  isLast: false,
                  index: index,
                  eachTuto: listTutoTimeline[index]);
            }
            if (index == listTutoTimeline.length - 1) {
              return buildTimeLine(context,
                  isFirst: false,
                  isLast: true,
                  index: index,
                  eachTuto: listTutoTimeline[index]);
            }
            return buildTimeLine(context,
                isFirst: false,
                isLast: false,
                index: index,
                eachTuto: listTutoTimeline[index]);
          },
        ),
      );

  //seedling, water,spraycan, eye, tractor
  Widget buildTimeLine(BuildContext context,
          {required bool isFirst,
          required bool isLast,
          required int index,
          required final eachTuto}) =>
      TimelineTile(
        axis: TimelineAxis.horizontal,
        alignment: TimelineAlign.center,
        isFirst: isFirst,
        isLast: isLast,
        startChild: Container(
          constraints: const BoxConstraints(minWidth: 120),
          child: Center(
            child: FaIcon(buildIcon(eachTuto['tutorialGroup']),
                size: 24,
                color: eachTuto['isPass']
                    ? CustomColor.getSecondaryColor(context)
                    : Colors.grey),
          ),
        ),
        endChild: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            eachTuto['tutorialGroup'],
            style: CustomTextStyle.getTitleStyle(
                context,
                15,
                eachTuto['isPass']
                    ? CustomColor.getSecondaryColor(context)
                    : Colors.grey),
          ),
        ),
        beforeLineStyle: LineStyle(
            color: eachTuto['isPass']
                ? CustomColor.getSecondaryColor(context).withOpacity(0.5)
                : Colors.grey),
        indicatorStyle: IndicatorStyle(
          height: 40,
          color: eachTuto['isPass']
              ? CustomColor.getSecondaryColor(context)
              : Colors.grey,
          iconStyle: IconStyle(
              fontSize: 24,
              iconData: Icons.task,
              color: CustomColor.getWhiteColor(context)),
        ),
      );

  IconData buildIcon(String tutorialGroup) {
    IconData fontAwesomeIcons;
    switch (tutorialGroup) {
      case 'Soil & Seed':
        fontAwesomeIcons = FontAwesomeIcons.seedling;
        break;
      case 'Irrigation':
        fontAwesomeIcons = FontAwesomeIcons.water;
        break;
      case 'Fertilize':
        fontAwesomeIcons = FontAwesomeIcons.sprayCan;
        break;
      case 'Monitor':
        fontAwesomeIcons = FontAwesomeIcons.eye;
        break;
      case 'Harvest':
        fontAwesomeIcons = FontAwesomeIcons.tractor;
        break;
      default:
        fontAwesomeIcons = FontAwesomeIcons.question;
    }
    return fontAwesomeIcons;
  }

  Widget buildListPage() => Expanded(
        child: PageView.builder(
          controller: pageController,
          itemCount: listTutoTimeline.length,
          itemBuilder: (context, index) {
            return setPages(listTutoTimeline[index]['tutorialGroup']);
          },
        ),
      );

  Widget setPages(String tutorialGroup) {
    switch (tutorialGroup) {
      case 'Soil & Seed':
      case 'Irrigation':
      case 'Fertilize':
      case 'Monitor':
      case 'Harvest':
        return ListView.builder(
          itemCount: listTuto.length,
          itemBuilder: (context, index) {
            if (listTuto[index]['tutorialGroup'] == tutorialGroup) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TutorialCard(
                  eachTuto: listTuto[index],
                ),
              );
            }
            return Container();
          },
        );
      default:
        return Container(); // Handle cases where tutorialGroup is not recognized
    }
  }
}

class TutorialCard extends StatelessWidget {
  final Map<String, dynamic> eachTuto;
  const TutorialCard({super.key, required this.eachTuto});

  @override
  Widget build(BuildContext context) {
    return buildTutorialCard(context);
  }

  Widget buildTutorialCard(BuildContext context) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: CustomColor.getPrimaryColor(context),
            border: Border.all(
              color: CustomColor.getSecondaryColor(context),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eachTuto['tutorialTitle'],
              style: CustomTextStyle.getTitleStyle(
                  context, 15, CustomColor.getTertieryColor(context)),
            ),
            const SizedBox(
              height: 10,
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(eachTuto['tutorialImage'])),
            const SizedBox(
              height: 10,
            ),
            Text(
              eachTuto['tutorialDesc'],
              style: CustomTextStyle.getSubTitleStyle(
                  context, 15, CustomColor.getTertieryColor(context)),
            )
          ],
        ),
      );
}
