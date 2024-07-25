import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:vhack_client/presentation/components/image/mynetwork_image.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';
import 'package:vhack_client/shared/constant/custom_string.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../shared/constant/custom_textstyle.dart';

class TimelineTuto extends StatelessWidget {
  final bool isFirst, isLast;
  final Map<String, dynamic> eachTuto;

  const TimelineTuto(
      {super.key,
      required this.isFirst,
      required this.isLast,
      required this.eachTuto});

  @override
  Widget build(BuildContext context) {
    return buildTimeLineTuto(context);
  }

  Widget buildTimeLineTuto(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TimelineTile(
          isFirst: isFirst,
          isLast: isLast,
          beforeLineStyle: LineStyle(
              color: CustomColor.getSecondaryColor(context).withOpacity(0.5)),
          indicatorStyle: IndicatorStyle(
              width: 40,
              color: CustomColor.getSecondaryColor(context),
              iconStyle: IconStyle(
                  fontSize: 24,
                  iconData: Icons.task,
                  color: CustomColor.getWhiteColor(context))),
          endChild: EventCard(
            eachTuto: eachTuto,
          ),
        ),
      );
}

class EventCard extends StatelessWidget {
  final Map<String, dynamic> eachTuto;
  const EventCard({super.key, required this.eachTuto});

  @override
  Widget build(BuildContext context) {
    return buildEventCard(context);
  }

  Widget buildEventCard(BuildContext context) => Container(
        margin: const EdgeInsets.only(left: 12, top: 12, bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: CustomColor.getPrimaryColor(context),
          border: Border.all(
              color: CustomColor.getSecondaryColor(context), width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eachTuto['tutorialGroup'],
              style: CustomTextStyle.getTitleStyle(
                  context, 15, CustomColor.getSecondaryColor(context)),
            ),
            const SizedBox(
              height: 10,
            ),
            CarouselSlider.builder(
                itemCount: 2,
                itemBuilder: (context, index, realIndex) {
                  return buildImage();
                },
                options: CarouselOptions(
                    height: 300,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 4),
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.scale)),
            const SizedBox(
              height: 10,
            ),
            Text(
              eachTuto['tutorialTitle'],
              style: CustomTextStyle.getSubTitleStyle(
                  context, 15, CustomColor.getTertieryColor(context)),
            ),
          ],
        ),
      );

  Widget buildImage() => Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey, width: 0.5)),
      child: Image.asset('assets/bacterial.png'));
}
