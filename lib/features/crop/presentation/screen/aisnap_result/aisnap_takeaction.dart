import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vhack_client/features/auth/domain/entity/user_entity.dart';
import 'package:vhack_client/features/crop/domain/entity/crop_entity.dart';
import 'package:vhack_client/features/crop/presentation/cubit/crop/crop_cubit.dart';
import 'package:vhack_client/features/crop/presentation/screen/analyze_screen.dart';
import 'package:vhack_client/presentation/components/button/text_button.dart';
import 'package:vhack_client/presentation/components/card/crop/result_card.dart';
import 'package:vhack_client/presentation/screen/bridge_screen.dart';
import 'package:vhack_client/presentation/screen/build/home_screen.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';
import 'package:vhack_client/shared/util/avatar_data.dart';
import 'package:vhack_client/shared/util/storage.dart';

class AISnapTakeActionScreen extends StatefulWidget {
  final UserEntity userEntity;
  final String cropCA;
  final CropEntity cropEntity;
  const AISnapTakeActionScreen(
      {super.key,
      required this.userEntity,
      required this.cropCA,
      required this.cropEntity});

  @override
  State<AISnapTakeActionScreen> createState() => _AISnapTakeActionScreenState();
}

class _AISnapTakeActionScreenState extends State<AISnapTakeActionScreen> {
  String actionsAgainstBacterialLeafBlight = '''
1. Remove and Destroy Infected Plants: Promptly remove any paddy plants showing symptoms of bacterial leaf blight and destroy them to prevent further spread of the disease.

2. Practice Crop Rotation: Rotate paddy crops with non-host plants to disrupt the disease cycle and reduce the buildup of bacteria in the soil.

3. Ensure Good Drainage: Improve field drainage to reduce the presence of standing water, which creates conditions conducive to bacterial leaf blight development.

4. Use Disease-Resistant Varieties: Plant paddy varieties that are resistant to bacterial leaf blight to minimize the risk of infection.

5. Apply Copper-Based Fungicides: Apply copper-based fungicides according to label instructions to help control bacterial leaf blight outbreaks and protect healthy plants.
''';

  bool isLoading = false;

  void saveCrop() async {
    setState(() {
      isLoading = true;
    });
    final crop = CropEntity(
        cropCA: widget.cropCA,
        cropDisease: widget.cropEntity.cropDisease,
        cropNutrient: widget.cropEntity.cropNutrient,
        cropPrecaution: widget.cropEntity.cropPrecaution,
        cropOwnerID: widget.userEntity.userID,
        cropImage: widget.cropEntity.cropImage);
    BlocProvider.of<CropCubit>(context)
        .postCrop(cropEntity: crop)
        .then((value) {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => BridgeScreen(
              userID: widget.userEntity.userID,
            ),
          ),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          buildResultImage(context),
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
          buildSaveButton(context)
        ],
      ),
    );
  }

  Widget buildResultImage(BuildContext context) {
    return Center(
      child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                  color: CustomColor.getSecondaryColor(context), width: 2)),
          child: buildImage(
              widget.cropEntity.cropImage!.avatarURL, 326.0, 234.0, 24)),
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
                resultDetail: widget.cropEntity.cropDisease!,
              )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: ResultCard(
                resultIcon: Icons.balance,
                resultTitle: 'Nutrient',
                resultDetail: widget.cropEntity.cropNutrient!,
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
            child: Text(widget.cropEntity.cropPrecaution!,
                style: CustomTextStyle.getSubTitleStyle(
                    context, 15, CustomColor.getTertieryColor(context))),
          ),
        ],
      ),
    );
  }

  Widget buildSaveButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextOnlyButton(
        buttonTitle: isLoading ? 'Loading...' : 'Save',
        onPressed: () {
          saveCrop();
        },
        isMain: true,
        borderRadius: 32,
      ),
    );
  }
}
