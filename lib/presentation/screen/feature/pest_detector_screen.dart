import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vhack_client/presentation/components/button/icon_text_button.dart';
import 'package:vhack_client/presentation/components/button/text_button.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';

class PestDetectorScreen extends StatefulWidget {
  const PestDetectorScreen({super.key});

  @override
  State<PestDetectorScreen> createState() => _PestDetectorScreenState();
}

class _PestDetectorScreenState extends State<PestDetectorScreen> {
  final currentLatLng = const LatLng(3.221806, 101.725659);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.getBackgroundColor(context),
      appBar: buildAppBar(),
      body: Column(
        children: [buildHeader(), buildBottom()],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: CustomColor.getSecondaryColor(context),
      elevation: 0.5,
      centerTitle: true,
      title: Text(
        'Pest Detector',
        style: CustomTextStyle.getTitleStyle(context, 18, Colors.white),
      ),
    );
  }

  Widget buildHeader() {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              border: Border.all(color: CustomColor.getSecondaryColor(context)),
              borderRadius: BorderRadius.circular(12)),
          child: buildGoogleMap()),
    ));
  }

  GoogleMap buildGoogleMap() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: currentLatLng, zoom: 10),
      onTap: (argument) {
        debugPrint(argument.toString());
      },
    );
  }

  Widget buildBottom() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(12),
            color: CustomColor.getPrimaryColor(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildBottomHeader(),
            const SizedBox(
              height: 20,
            ),
            buildBottomButtons()
          ],
        ),
      ),
    );
  }

  Widget buildBottomHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Device 1',
          style: CustomTextStyle.getTitleStyle(
              context, 15, CustomColor.getTertieryColor(context)),
        ),
        Text(
          'Put coordinate here',
          style: CustomTextStyle.getSubTitleStyle(
            context,
            12,
            CustomColor.getTertieryColor(context),
          ),
        )
      ],
    );
  }

  Widget buildBottomButtons() {
    return Column(
      children: [
        IconTextButton(
          buttonTitle: 'Play Sound',
          buttonIcon: Icons.play_arrow,
          onPressed: () {},
        ),
        const SizedBox(
          height: 10,
        ),
        TextOnlyButton(
            buttonTitle: 'Cancel',
            onPressed: () {},
            isMain: false,
            borderRadius: 12)
      ],
    );
  }
}
