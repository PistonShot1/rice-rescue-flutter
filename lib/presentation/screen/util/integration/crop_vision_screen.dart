import 'package:flutter/material.dart';
import 'package:vhack_client/presentation/components/button/text_button.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';
import 'package:vhack_client/shared/constant/custom_string.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';

class CropVisionScreen extends StatelessWidget {
  CropVisionScreen({super.key});

  String description =
      'Crop Vision is an innovative AI-powered technology integrated into our application, designed to revolutionize crop management practices. Leveraging machine learning algorithms, Crop Vision enables users to detect diseases and assess nutrient deficiencies in crops with unprecedented accuracy. By analyzing images of the plants captured using smartphones or drones, Crop Vision provides real-time insights into the health and condition of the crops. This technology allows farmers to take timely intervention measures, such as targeted pest control or precision fertilization, to optimize crop health and maximize yield potential. With Crop Vision, users can make data-driven decisions, enhance productivity, and ensure the overall success of their farming operations.';

  List<Map<String, dynamic>> features = [
    {'title': 'Disease Detection', 'icon': Icons.history},
    {'title': 'Nutrient Deficiency Assessment', 'icon': Icons.area_chart},
    {'title': 'Timely Intervation', 'icon': Icons.remove_red_eye},
    {'title': 'Optimal Crop Health', 'icon': Icons.fast_forward}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColor.getBackgroundColor(context),
        appBar: buildAppBar(context),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: buildImage(),
            ),
            buildSizeBox(20),
            SliverToBoxAdapter(
              child: buildTitle(context),
            ),
            buildSizeBox(20),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'You Get:',
                  style: CustomTextStyle.getTitleStyle(
                      context, 15, CustomColor.getTertieryColor(context)),
                ),
              ),
            ),
            buildSizeBox(10),
            buildList(),
            buildSizeBox(10),
            SliverToBoxAdapter(child: buildButton())
          ],
        ));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColor.getSecondaryColor(context),
      centerTitle: true,
      title: Text(
        'Crop Vision Integration',
        style: CustomTextStyle.getTitleStyle(
            context, 18, CustomColor.getWhiteColor(context)),
      ),
      automaticallyImplyLeading: true,
    );
  }

  Widget buildImage() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey, width: 0.5),
          color: Colors.white,
        ),
        child: Image.asset(
          'assets/integration/crop_integration.png',
          height: 300,
          fit: BoxFit.fitWidth,
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
            'Take advantage of the precise Soil Data',
            style: CustomTextStyle.getTitleStyle(
                context, 18, CustomColor.getTertieryColor(context)),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            description,
            style: CustomTextStyle.getSubTitleStyle(
                context, 12, CustomColor.getTertieryColor(context)),
          ),
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
          buttonTitle: 'Subscription',
          onPressed: () {},
          isMain: true,
          borderRadius: 12),
    );
  }

  Widget buildSizeBox(double value) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: value,
      ),
    );
  }
}
