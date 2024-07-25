import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vhack_client/presentation/components/card/service/service_card.dart';
import 'package:vhack_client/presentation/screen/util/services/service_consultant_screen.dart';
import 'package:vhack_client/presentation/screen/util/services/service_fm_screen.dart';
import 'package:vhack_client/presentation/screen/util/services/service_pf_screen.dart';
import 'package:vhack_client/presentation/screen/util/services/service_shop_screen.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  void serviceNavigation(String serviceTitle) {
    final Map<String, Widget Function(BuildContext)> serviceRoutes = {
      'Consultation': (context) => ServiceConsultantScreen(),
      'Pesticides & Fertilizing Services': (context) => ServicePFScreen(),
      'Shop': (context) => ServiceShopScreen(),
      'Fixing & Maintenance': (context) => ServiceFMScreen(),
    };

    final Widget Function(BuildContext)? selectedRoute =
        serviceRoutes[serviceTitle];
    if (selectedRoute != null) {
      Navigator.of(context).push(MaterialPageRoute(builder: selectedRoute));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.getBackgroundColor(context),
      appBar: buildAppBar(context),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        buildHeader(context),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
              decoration: BoxDecoration(
                color: CustomColor.getPrimaryColor(context),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey, width: 0.5),
              ),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  buildServiceCard(
                      serviceTitle: 'Consultation',
                      serviceDesc:
                          'Consult with expertise from field to finance',
                      serviceIcon: Icons.person),
                  buildDivider(),
                  buildServiceCard(
                      serviceTitle: 'Pesticides & Fertilizing Services',
                      serviceDesc:
                          'Drone spray services to manual spray services',
                      serviceIcon: Icons.spa),
                  buildDivider(),
                  buildServiceCard(
                      serviceTitle: 'Shop',
                      serviceDesc:
                          'Tools, fertilizers, persticides & machinery',
                      serviceIcon: Icons.shopping_cart),
                  buildDivider(),
                  buildServiceCard(
                      serviceTitle: 'Fixing & Maintenance',
                      serviceDesc: 'Trector, Drone, Machinery',
                      serviceIcon: Icons.handyman),
                  const SizedBox(
                    height: 10,
                  )
                ],
              )),
        )
      ]),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColor.getSecondaryColor(context),
      elevation: 0.5,
      centerTitle: true,
      title: Text(
        'Services',
        style: CustomTextStyle.getTitleStyle(
            context, 18, CustomColor.getWhiteColor(context)),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'All in One Services',
            style: CustomTextStyle.getTitleStyle(
                context, 21, CustomColor.getTertieryColor(context)),
          ),
          Text(
            'Complete Solutions, Start to Finish',
            style: CustomTextStyle.getSubTitleStyle(
                context, 15, CustomColor.getTertieryColor(context)),
          ),
        ],
      ),
    );
  }

  Widget buildServiceCard(
      {required String serviceTitle,
      required String serviceDesc,
      required IconData serviceIcon}) {
    return GestureDetector(
      onTap: () {
        serviceNavigation(serviceTitle);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ServiceCard(
            serviceTitle: serviceTitle,
            serviceDesc: serviceDesc,
            serviceIcon: serviceIcon),
      ),
    );
  }

  Widget buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Divider(
        color: Colors.grey,
        thickness: 1,
      ),
    );
  }
}
