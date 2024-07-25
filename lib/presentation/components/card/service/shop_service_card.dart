import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../shared/constant/custom_color.dart';
import '../../../../shared/constant/custom_textstyle.dart';

class ShopServiceCard extends StatelessWidget {
  final Map<String, dynamic> shopEntity;
  const ShopServiceCard({super.key, required this.shopEntity});

  @override
  Widget build(BuildContext context) {
    return buildShopCard(context);
  }

  Widget buildShopCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey, width: 0.5),
          color: CustomColor.getPrimaryColor(context)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.favorite_outlined,
                color: Colors.grey,
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          buildImage(shopEntity['userAvatar'], 400, 100),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Text(
                shopEntity['userCompanyName'],
                style: CustomTextStyle.getSubTitleStyle(
                    context, 12, CustomColor.getTertieryColor(context)),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              Text(
                shopEntity['userCompanyName'],
                style: CustomTextStyle.getTitleStyle(
                    context, 12, CustomColor.getSecondaryColor(context)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildImage(String pathURL, double width, double height) {
    return SizedBox(
        height: height,
        width: width,
        child: ClipRRect(
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
}
