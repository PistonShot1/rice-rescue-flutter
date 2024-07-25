import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vhack_client/features/auth/domain/entity/user_entity.dart';
import 'package:vhack_client/features/crop/domain/entity/crop_entity.dart';
import 'package:vhack_client/presentation/components/button/gradient_button.dart';
import 'package:vhack_client/presentation/components/button/text_button.dart';
import 'package:vhack_client/features/crop/presentation/screen/aisnap_result/aisnap_disease.dart';
import 'package:vhack_client/features/crop/presentation/screen/aisnap_result/aisnap_nutrient.dart';
import 'package:vhack_client/features/crop/presentation/screen/aisnap_result/aisnap_takeaction.dart';
import 'package:vhack_client/shared/constant/custom_appbar.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';

class AISnapResultScreen extends StatefulWidget {
  final UserEntity userEntity;
  final String cropCA;
  final CropEntity cropEntity;
  const AISnapResultScreen(
      {super.key,
      required this.userEntity,
      required this.cropCA,
      required this.cropEntity});

  @override
  State<AISnapResultScreen> createState() => _AISnapResultScreenState();
}

class _AISnapResultScreenState extends State<AISnapResultScreen> {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColor.getBackgroundColor(context),
        appBar: CustomAppBar.BuildMainAppBar(context, false),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                children: [
                  AISnapNutrientScreen(
                    cropEntity: widget.cropEntity,
                  ),
                  AISnapDiseaseScreen(
                    cropEntity: widget.cropEntity,
                  ),
                  AISnapTakeActionScreen(
                    userEntity: widget.userEntity,
                    cropCA: widget.cropCA,
                    cropEntity: widget.cropEntity,
                  )
                ],
              ),
            ),
            buildBottom()
          ],
        ));
  }

  Widget buildBottom() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 15),
      child: SmoothPageIndicator(
        controller: pageController,
        count: 3,
        effect:
            WormEffect(activeDotColor: CustomColor.getSecondaryColor(context)),
      ),
    );
  }
}
