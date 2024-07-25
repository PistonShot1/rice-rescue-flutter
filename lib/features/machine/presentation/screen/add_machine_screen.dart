import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vhack_client/features/auth/domain/entity/user_entity.dart';
import 'package:vhack_client/features/machine/domain/entity/machine_entity.dart';
import 'package:vhack_client/features/machine/presentation/cubit/machine/machine_cubit.dart';
import 'package:vhack_client/presentation/components/button/icon_text_button.dart';
import 'package:vhack_client/presentation/components/button/text_button.dart';
import 'package:vhack_client/presentation/components/textfield/input_textfield.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';
import 'package:vhack_client/shared/constant/custom_snackbar.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';
import 'package:vhack_client/shared/util/avatar_data.dart';
import 'package:file_picker/file_picker.dart';
import 'package:vhack_client/shared/util/storage.dart';

class AddMachineScreen extends StatefulWidget {
  UserEntity userEntity;
  AddMachineScreen({super.key, required this.userEntity});

  @override
  State<AddMachineScreen> createState() => _AddMachineScreenState();
}

class _AddMachineScreenState extends State<AddMachineScreen> {
  final TextEditingController tcMachineName = TextEditingController();
  final TextEditingController tcPersonInCharge = TextEditingController();
  final TextEditingController tcAddInfo = TextEditingController();
  File? selectedImage;
  bool isLoading = false;

  void pickImage(ImageSource source) async {
    try {
      final imagepicked = await ImagePicker().pickImage(source: source);
      if (imagepicked == null) {
        return;
      }
      setState(() {
        selectedImage = File(imagepicked.path);
      });
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      SnackBarUtil.showSnackBar(e.toString(), Colors.red);
    } catch (e) {
      debugPrint(e.toString());
      SnackBarUtil.showSnackBar(e.toString(), Colors.red);
    }
  }

  void addMachine() async {
    setState(() {
      isLoading = true;
    });
    if (selectedImage == null) {
      SnackBarUtil.showSnackBar('Please select an image', Colors.red);
      return;
    }

    final machineImage = await Storage.getURL(
        selectedFile: selectedImage!,
        userEntity: widget.userEntity,
        path: 'machine');

    if (machineImage == null) {
      SnackBarUtil.showSnackBar('Failed to upload image', Colors.red);
      return;
    }

    BlocProvider.of<MachineCubit>(context)
        .postMachine(
      machineEntity: MachineEntity(
          machineName: tcMachineName.text,
          machineDesc: tcAddInfo.text,
          machineImage: machineImage,
          machinePICsID: [],
          machineOwnerID: widget.userEntity.userID,
          machineStatus: true),
    )
        .then((value) {
      Navigator.pop(context);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColor.getBackgroundColor(context),
        appBar: buildAppBar(),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: buildImage(),
            ),
            buildSizeBox(20),
            SliverToBoxAdapter(
              child: buildText(),
            ),
            buildSizeBox(20),
            SliverToBoxAdapter(
              child: buildUploadButton(),
            ),
            buildSizeBox(40),
            SliverToBoxAdapter(
              child: buildTextFieldForm(),
            ),
            buildSizeBox(40),
            SliverToBoxAdapter(
              child: buildButtonForm(),
            )
          ],
        ));
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: CustomColor.getSecondaryColor(context),
      centerTitle: true,
      title: Text(
        'Add Machines',
        style: CustomTextStyle.getTitleStyle(
            context, 18, CustomColor.getWhiteColor(context)),
      ),
    );
  }

  Widget buildImage() {
    if (selectedImage == null) {
      return buildPlaceHolderImage();
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.file(
            selectedImage!,
            height: 200,
            width: 200,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }

  Widget buildPlaceHolderImage() {
    return Image.asset(
      "assets/gif/tractorMachines.gif",
      height: 200.0,
      width: 200.0,
    );
  }

  Widget buildText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Add Your Machines',
            style: CustomTextStyle.getTitleStyle(
                context, 18, CustomColor.getTertieryColor(context)),
          ),
          Text(
            'AI-Powered Paddy Analysis for Optimal Health',
            style: CustomTextStyle.getSubTitleStyle(
                context, 15, CustomColor.getTertieryColor(context)),
          )
        ],
      ),
    );
  }

  Widget buildUploadButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: IconTextButton(
        buttonTitle: 'Upload Image',
        buttonIcon: Icons.photo_size_select_actual_outlined,
        onPressed: () {
          pickImage(ImageSource.gallery);
        },
      ),
    );
  }

  Widget buildTextFieldForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          InputTextField(
              tcInput: tcMachineName,
              tcTitle: 'Machine Name',
              tcIcon: Icons.photo_size_select_actual_outlined),
          const SizedBox(
            height: 10,
          ),
          InputTextField(
              tcInput: tcPersonInCharge,
              tcTitle: 'Person In Charge',
              tcIcon: Icons.group_outlined),
          const SizedBox(
            height: 10,
          ),
          InputTextField(
              tcInput: tcAddInfo,
              tcTitle: 'Additional Info',
              tcIcon: Icons.add_outlined),
        ],
      ),
    );
  }

  Widget buildButtonForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          TextOnlyButton(
              buttonTitle: isLoading ? 'Loading...' : 'Confirm',
              onPressed: () {
                addMachine();
              },
              isMain: true,
              borderRadius: 12),
          const SizedBox(
            height: 10,
          ),
          TextOnlyButton(
              buttonTitle: 'Cancel',
              onPressed: () {},
              isMain: false,
              borderRadius: 12)
        ],
      ),
    );
  }

  Widget buildSizeBox(double value) {
    return SliverToBoxAdapter(
      child: SizedBox(height: value),
    );
  }
}
