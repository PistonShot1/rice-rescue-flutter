import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vhack_client/features/crop/domain/entity/crop_entity.dart';

import '../../../../../shared/constant/custom_color.dart';
import '../../../../../shared/constant/custom_textstyle.dart';

class AISnapDiseaseScreen extends StatelessWidget {
  final CropEntity cropEntity;
  AISnapDiseaseScreen({super.key, required this.cropEntity});

  String bacterialLeafBlightDescription = '''
Bacterial leaf blight is a common disease in paddy plants caused by bacteria. 
It manifests as brown lesions on leaves, which can significantly reduce crop yield. 
This disease spreads quickly, especially in humid conditions.
''';

  String title(CropEntity cropEntity) {
    String cropDisease = cropEntity.cropDisease!;

    Map<String, String> diseaseDescriptions = {
      'Bacterial leaf blight':
          'This disease manifests as water-soaked lesions on the leaves, which later turn bluish-black and elongated. As the infection progresses, the lesions may merge, leading to extensive damage. Infected plants show reduced growth and yield, making it a significant concern for paddy farmers.',
      'Brown spot':
          'Brown spot appears as small, dark brown spots with yellow halos on the leaves. As the disease progresses, these spots may enlarge and coalesce, leading to the yellowing and drying of affected leaves. Severe infections can reduce photosynthesis, weaken the plant, and reduce grain quality.',
      'Leaf smut':
          'Leaf smut is characterized by the formation of dark, powdery masses on the leaves, which are actually spore-producing structures of the fungus. Infected leaves may also show abnormal growth or twisting. This disease can reduce the plant\'s vigor and eventually lead to yield losses if not managed timely.',
    };

    return diseaseDescriptions[cropDisease] ??
        'No description available for this disease';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildImage(context),
        const SizedBox(
          height: 40,
        ),
        buildDetail(context)
      ],
    );
  }

  Widget buildImage(BuildContext context) {
    return Image.asset(
      'assets/bacterial.png',
      height: 250,
      width: 250,
    );
  }

  Widget buildDetail(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text('Disease',
              style: CustomTextStyle.getTitleStyle(
                  context, 21, CustomColor.getTertieryColor(context))),
          const SizedBox(
            height: 20,
          ),
          Text(cropEntity.cropDisease!,
              style: CustomTextStyle.getSubTitleStyle(
                  context, 18, CustomColor.getTertieryColor(context))),
          const SizedBox(
            height: 20,
          ),
          Text(
            title(cropEntity),
            style: CustomTextStyle.getSubTitleStyle(
                context, 14, CustomColor.getTertieryColor(context)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
