import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vhack_client/presentation/components/button/text_button.dart';
import 'package:vhack_client/presentation/screen/bridge_screen.dart';
import 'package:vhack_client/presentation/screen/util/welcome/welcome_exp_screen.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  List<Map<String, dynamic>> listWelcome = [
    {
      'welcomeTitle': 'Streamline The Process',
      'welcomeDesc':
          'RiseRescue simplifies and optimizes every step of your paddy cultivation journey, from planting to harvesting.',
      'welcomeIcon': Icons.bolt
    },
    {
      'welcomeTitle': 'IoT Integration',
      'welcomeDesc':
          'Seamlessly connect with IoT devices to gather real-time data on soil conditions, weather patterns, and crop health for smarter decision-making.',
      'welcomeIcon': Icons.wifi
    },
    {
      'welcomeTitle': 'Task Management',
      'welcomeDesc':
          'Organize and track tasks efficiently, ensuring timely completion of essential activities throughout the crop cycle.',
      'welcomeIcon': Icons.assessment
    },
    {
      'welcomeTitle': 'Disease and Pest Detection',
      'welcomeDesc':
          'Utilize advanced AI technology to detect and diagnose diseases and pests in your paddy field, allowing for early intervention and improved crop yields.',
      'welcomeIcon': Icons.bug_report
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.getBackgroundColor(context),
      appBar: AppBar(
        backgroundColor: CustomColor.getBackgroundColor(context),
        elevation: 0,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          buildHeader(context),
          const SizedBox(
            height: 60,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listWelcome.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: buildWelcomeCard(context, listWelcome[index]),
              );
            },
          ),
          const SizedBox(
            height: 60,
          ),
          buildContinueButton(context)
        ]),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(
            'Welcome To Rice Rescue',
            style: CustomTextStyle.getTitleStyle(
                context, 28, CustomColor.getTertieryColor(context)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'For Paddy Care From Seed To Harvest',
            style: CustomTextStyle.getSubTitleStyle(
                context, 15, CustomColor.getTertieryColor(context)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget buildWelcomeCard(
      BuildContext context, Map<String, dynamic> eachWelcome) {
    return ListTile(
      leading: Icon(
        eachWelcome['welcomeIcon'],
        color: CustomColor.getSecondaryColor(context),
      ),
      title: Text(
        eachWelcome['welcomeTitle'],
        style: CustomTextStyle.getTitleStyle(
            context, 15, CustomColor.getTertieryColor(context)),
      ),
      subtitle: Text(
        eachWelcome['welcomeDesc'],
        style: CustomTextStyle.getSubTitleStyle(
            context, 12, CustomColor.getTertieryColor(context)),
      ),
    );
  }

  Widget buildContinueButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextOnlyButton(
          buttonTitle: 'Continue',
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => WelcomeExpScreen(),
                ),
                (route) => false);
          },
          isMain: true,
          borderRadius: 12),
    );
  }
}
