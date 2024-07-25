import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../shared/constant/custom_color.dart';
import '../../../../shared/constant/custom_textstyle.dart';
import '../../../components/card/service/user_service_card.dart';
import '../user/user_detail_screen.dart';

class ServiceFMScreen extends StatefulWidget {
  const ServiceFMScreen({super.key});

  @override
  State<ServiceFMScreen> createState() => _ServiceFMScreenState();
}

class _ServiceFMScreenState extends State<ServiceFMScreen> {
  final List<Map<String, dynamic>> listUser = [
    {
      'userName': 'Muhammad Arfan',
      'userAvatar':
          'https://t4.ftcdn.net/jpg/04/72/63/81/360_F_472638196_0r0GDFu2sQ16DZcVuzPF1lPouVOMAuot.jpg',
      'userJobType': 'Agricultural Consultant',
      'userAge': '39 Years old',
      'userExperience': '4 years',
      'userAbout':
          'Muhammad Arfan, a seasoned Agricultural Engineer with 4 years of experience, specializes in optimizing drone-based solutions for agricultural needs.',
      'userCompanyName': 'MZM TUALANG ENTERPRISE',
      'userDescription':
          'MZM TUALANG ENTERPRISE specializes in agriculture-drone related services, including the spraying of insecticides, pesticides, weed, and fungus control.',
      'userOperatingHours': [
        {'operatingDay': 'Monday', 'operatingHour': '9:00 AM - 6:30 PM'},
        {'operatingDay': 'Tuesday', 'operatingHour': '9:00 AM - 6:30 PM'},
        {'operatingDay': 'Wednesday', 'operatingHour': '9:00 AM - 6:30 PM'},
        {'operatingDay': 'Thursday', 'operatingHour': '9:00 AM - 6:30 PM'},
        {'operatingDay': 'Friday', 'operatingHour': '9:00 AM - 6:30 PM'},
        {'operatingDay': 'Saturday', 'operatingHour': 'Closed'},
        {'operatingDay': 'Sunday', 'operatingHour': 'Closed'}
      ]
    },
    {
      'userName': 'Muhammad Mulyadi',
      'userAvatar':
          'https://cdn1.npcdn.net/images/20190319_dea25f.webp?md5id=67aa32a1a83b0ac24b4a944f48c6af77&new_width=1000&new_height=1000&size=max&w=1707353261&from=jpg&type=1',
      'userJobType': 'Machinery Maintenance and Repair Specialist',
      'userAge': '25 Years old',
      'userExperience': '4 years',
      'userAbout':
          'With four years of hands-on experience in fixing and maintaining industrial machinery, Muhammad Mulyadi is dedicated to ensuring optimal performance and reliability in machine operations.',
      'userCompanyName': 'MSE Laser',
      'userDescription':
          'Founded in 2002, MSE Industries Sdn Bhd (MSE) is a dynamic company known for its expertise in laser welding and thermal spray solutions. Headquartered in Bandar Pinggiran Subang, Selangor Darul Ehsan, MSE offers reliable and sustainable products and services for critical welding maintenance and integration applications. With subsidiary companies like MSE Lasertech (M) Sdn Bhd, MSE extends its reach both locally and internationally, providing comprehensive consultancy and supply services to various industries, including engineering, oil & gas, and aviation. MSE is committed to delivering innovative solutions and outstanding service to meet the diverse needs of its customers.',
      'userOperatingHours': [
        {'operatingDay': 'Saturday', 'operatingHour': '9:00 AM - 2:30 PM'},
        {'operatingDay': 'Sunday', 'operatingHour': 'Closed'},
        {'operatingDay': 'Monday', 'operatingHour': '9:00 AM - 6:00 PM'},
        {'operatingDay': 'Tuesday', 'operatingHour': '9:00 AM - 6:00 PM'},
        {'operatingDay': 'Wednesday', 'operatingHour': '9:00 AM - 6:00 PM'},
        {'operatingDay': 'Thursday', 'operatingHour': '9:00 AM - 6:00 PM'},
        {'operatingDay': 'Friday', 'operatingHour': '9:00 AM - 6:00 PM'}
      ]
    }
  ];

  List listChip = [
    ['Organic', false],
    ['Machinery', false]
  ];

  void setSelected(bool value, int index) {
    setState(() {
      listChip[index][1] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColor.getBackgroundColor(context),
        appBar: buildAppBar(),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: listUser.length,
                itemBuilder: (context, index) {
                  return buildUserServiceCard(listUser[index]);
                },
              ),
            )
          ],
        ));
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: CustomColor.getSecondaryColor(context),
      elevation: 0.5,
      centerTitle: true,
      title: Text(
        'Fixing & Maintenance',
        style: CustomTextStyle.getTitleStyle(
            context, 18, CustomColor.getWhiteColor(context)),
      ),
    );
  }

  Widget buildListChip() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 16, left: 16),
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listChip.length,
          itemBuilder: (context, index) {
            String eachChip = listChip[index][0];
            bool eachSelected = listChip[index][1];
            return buildChip(eachChip, eachSelected, index);
          },
        ),
      ),
    );
  }

  Widget buildChip(String eachChip, bool eachSelected, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ChoiceChip(
        label: Text(eachChip),
        labelStyle: CustomTextStyle.getTitleStyle(
            context,
            12,
            eachSelected
                ? CustomColor.getWhiteColor(context)
                : CustomColor.getTertieryColor(context)),
        backgroundColor: Colors.black26,
        selectedColor: CustomColor.getSecondaryColor(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        selected: eachSelected,
        onSelected: (value) {
          setSelected(value, index);
        },
      ),
    );
  }

  Widget buildUserServiceCard(final userEntity) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: UserServiceCard(
        userEntity: userEntity,
        voidCallback: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => UserDetailScreen(
              eachUser: userEntity,
            ),
          ));
        },
      ),
    );
  }
}
