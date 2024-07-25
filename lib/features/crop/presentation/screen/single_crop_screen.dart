import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vhack_client/features/crop/domain/entity/crop_entity.dart';
import 'package:vhack_client/shared/constant/custom_appbar.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';

import '../../../../presentation/components/button/text_button.dart';
import '../../../../presentation/components/card/crop/result_card.dart';
import '../../../../shared/constant/custom_textstyle.dart';

class SingleCropScreen extends StatelessWidget {
  final CropEntity cropEntity;
  const SingleCropScreen({super.key, required this.cropEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.getBackgroundColor(context),
      appBar: CustomAppBar.BuildMainAppBar(context, false),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: buildImage(cropEntity.cropImage!.avatarURL,
                  MediaQuery.of(context).size.width, 250, 16),
            ),
            const SizedBox(
              height: 20,
            ),
            buildResult(context),
            const SizedBox(
              height: 20,
            ),
            buildActionToTake(context),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage(
      String pathURL, double width, double height, double radius) {
    return SizedBox(
        height: height,
        width: width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: pathURL == ''
              ? Image.asset('assets/riserescuelogo.png', fit: BoxFit.cover)
              : CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: pathURL,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  ),
                ),
        ));
  }

  Widget buildResult(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Results',
              style: CustomTextStyle.getTitleStyle(
                context,
                18,
                CustomColor.getTertieryColor(context),
              )),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                  child: ResultCard(
                resultIcon: Icons.coronavirus_outlined,
                resultTitle: 'Disease',
                resultDetail: cropEntity.cropDisease!,
              )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: ResultCard(
                resultIcon: Icons.balance,
                resultTitle: 'Nutrient',
                resultDetail: cropEntity.cropNutrient!,
              )),
            ],
          )
        ],
      ),
    );
  }

  Widget buildActionToTake(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Action To Take',
              style: CustomTextStyle.getTitleStyle(
                context,
                18,
                CustomColor.getTertieryColor(context),
              )),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey),
              color: CustomColor.getPrimaryColor(context),
            ),
            child: Text(cropEntity.cropPrecaution!,
                style: CustomTextStyle.getSubTitleStyle(
                    context, 15, CustomColor.getTertieryColor(context))),
          ),
        ],
      ),
    );
  }
}
