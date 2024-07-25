import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vhack_client/features/crop/domain/entity/crop_entity.dart';
import 'package:vhack_client/presentation/components/chart/custom_slider.dart';
import 'package:vhack_client/shared/constant/custom_appbar.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';

class AISnapNutrientScreen extends StatelessWidget {
  final CropEntity cropEntity;
  AISnapNutrientScreen({super.key, required this.cropEntity});

  String nutrientDeficiencies = '''
Nutrient deficiencies occur when plants don't get enough essential elements for growth and development. 
This can lead to various symptoms depending on the nutrient lacking.
''';
  double convertToPercentage() {
    String nutrientString = cropEntity.cropNutrient!.replaceAll('%', '');
    double nutrient = double.parse(nutrientString);
    return nutrient;
  }

  String title(CropEntity cropEntity) {
    String nutrientString = cropEntity.cropNutrient!.replaceAll('%', '');
    double nutrient = double.parse(nutrientString);
    if (nutrient < 25) {
      return "1st Phase of Deficiency";
    } else if (nutrient < 50) {
      return "2nd Phase of Deficiency";
    } else if (nutrient < 75) {
      return "3rd Phase of Deficiency";
    } else if (nutrient <= 100) {
      return "4th Phase of Deficiency";
    } else {
      return "Invalid nutrient level";
    }
  }

  String desc(CropEntity cropEntity) {
    String nutrientString = cropEntity.cropNutrient!.replaceAll('%', '');
    double nutrient = double.parse(nutrientString);
    if (nutrient < 25) {
      return "At this stage, the paddy plants may show subtle signs like yellowing or light green coloration of the older leaves. The growth rate might slow down, but it's not immediately alarming.";
    } else if (nutrient < 50) {
      return "The older leaves start to show more pronounced discoloration, turning yellow or brown. These symptoms are more evident on the lower leaves while the newer leaves remain relatively healthy.";
    } else if (nutrient < 75) {
      return "Both old and new leaves exhibit severe discoloration, and the growth of the entire plant is stunted. The leaves may curl or show signs of necrosis (dead tissue), affecting the plant's ability to photosynthesize effectively.";
    } else if (nutrient <= 100) {
      return "At this stage, the paddy plants are severely affected, with most leaves showing extensive damage or even dropping off. The plants are highly stunted, and the yield potential is significantly reduced, leading to substantial economic losses for the farmer.";
    } else {
      return "Invalid nutrient level";
    }
  }

  Color color(CropEntity cropEntity) {
    String nutrientString = cropEntity.cropNutrient!.replaceAll('%', '');
    double nutrient = double.parse(nutrientString);
    if (nutrient < 25) {
      return Colors.green;
    } else if (nutrient < 50) {
      return Colors.yellow;
    } else if (nutrient < 75) {
      return Colors.orange;
    } else if (nutrient <= 100) {
      return Colors.red;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildProgressBar(context),
        const SizedBox(
          height: 40,
        ),
        buildDetail(context)
      ],
    );
  }

  Widget buildProgressBar(BuildContext context) {
    return CircularPercentIndicator(
      percent: convertToPercentage() / 100,
      radius: 200,
      lineWidth: 30,
      animation: true,
      animateFromLastPercent: true,
      progressColor: color(cropEntity),
      backgroundColor: Colors.grey.shade300,
      center: Text(cropEntity.cropNutrient!,
          style: CustomTextStyle.getTitleStyle(context, 21, color(cropEntity))),
    );
  }

  Widget buildDetail(BuildContext context) {
    return Column(
      children: [
        Text('Nutrient',
            style: CustomTextStyle.getTitleStyle(
                context, 21, CustomColor.getTertieryColor(context))),
        const SizedBox(
          height: 20,
        ),
        Text(title(cropEntity),
            style: CustomTextStyle.getSubTitleStyle(
                context, 18, CustomColor.getTertieryColor(context))),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            desc(cropEntity),
            style: CustomTextStyle.getSubTitleStyle(
                context, 14, CustomColor.getTertieryColor(context)),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
