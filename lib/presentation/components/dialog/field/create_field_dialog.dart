import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vhack_client/features/field/domain/entity/field_entity.dart';
import 'package:vhack_client/features/field/presentation/cubit/field/field_cubit.dart';
import 'package:vhack_client/features/field/presentation/provider/field_provider.dart';
import 'package:vhack_client/presentation/components/button/text_button.dart';
import 'package:vhack_client/presentation/components/dropdown/my_dropdown.dart';
import 'package:vhack_client/presentation/components/textfield/date_textfield.dart';
import 'package:vhack_client/presentation/components/textfield/input_textfield.dart';
import 'package:vhack_client/presentation/screen/build/home_screen.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';

import '../../../../shared/constant/custom_snackbar.dart';
import '../../../screen/bridge_screen.dart';

class CreateFieldDialog extends StatefulWidget {
  final String userID;

  CreateFieldDialog({
    super.key,
    required this.userID,
  });

  @override
  State<CreateFieldDialog> createState() => _CreateFieldDialogState();
}

class _CreateFieldDialogState extends State<CreateFieldDialog> {
  final List<String> _listCA = [
    'Rainfed Lowland',
    'Irrigated Lowland',
    'Upland'
  ];

  String? selectedCA;
  DateTime? seedDate;

  bool isLoading = false;

  final TextEditingController tcFieldName = TextEditingController();
  final TextEditingController tcPCT = TextEditingController();
  final TextEditingController tcSeedDate = TextEditingController();

  void _postField(List<LatLng> locations) {
    List<LocationEntity> locationEntities = locations.map((latLng) {
      return LocationEntity(lat: latLng.latitude, long: latLng.longitude);
    }).toList();

    BlocProvider.of<FieldCubit>(context)
        .postField(
            fieldEntity: FieldEntity(
                fieldName: tcFieldName.text,
                fieldCA: selectedCA,
                fieldOwnerID: widget.userID,
                fieldPCT: tcPCT.text,
                fieldSeedDate: tcSeedDate.text,
                locationEntity: locationEntities))
        .then((value) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => BridgeScreen(
                userID: widget.userID,
              ),
            ),
            (route) => false));
  }

  void _saveField(BuildContext context, List<LatLng> locations) {
    setState(() {
      isLoading = true;
    });
    if (locations.isEmpty) {
      SnackBarUtil.showSnackBar(
          'Please Mark Your Field', CustomColor.getSecondaryColor(context));
      Navigator.pop(context);
    } else {
      _postField(locations);
    }
    setState(() {
      isLoading = false;
    });
    Provider.of<FieldProvider>(context, listen: false).resetLocation();
  }

  void selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: CustomColor.getSecondaryColor(
                context), // Your custom color here
            colorScheme: ColorScheme.light(
                primary: CustomColor.getSecondaryColor(context)),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(pickedDate);
      setState(() {
        tcSeedDate.text = formattedDate;
        seedDate = pickedDate;
      });
    } else {
      debugPrint('Date Null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FieldProvider>(
        builder: (context, value, child) => Column(
              children: [
                buildTitle(context),
                const SizedBox(
                  height: 20,
                ),
                buildTextFieldForm(context),
                const SizedBox(
                  height: 20,
                ),
                buildButtonForm(context, value.listLocation)
              ],
            ));
  }

  Widget buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, top: 10),
      child: Column(
        children: [
          buildTopChip(),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Field Detail',
            style: CustomTextStyle.getTitleStyle(
                context, 18, CustomColor.getTertieryColor(context)),
          ),
        ],
      ),
    );
  }

  Widget buildTextFieldForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          InputTextField(
              tcInput: tcFieldName, tcTitle: 'Field Name', tcIcon: Icons.edit),
          const SizedBox(
            height: 10,
          ),
          InputTextField(
              tcInput: tcPCT,
              tcTitle: 'Paddy Crop Type',
              tcIcon: Icons.forest_outlined),
          const SizedBox(
            height: 10,
          ),
          MyDropDown(
              inputs: _listCA,
              selectedInput: selectedCA,
              onChanged: (value) {
                setState(() {
                  selectedCA = value;
                });
              },
              dropdownTitle: 'Cultivation Area'),
          const SizedBox(
            height: 10,
          ),
          DateTextField(
              tcDate: tcSeedDate,
              onTap: () {
                selectDate();
              },
              hintTextField: 'Seeding Date (Optional)'),
        ],
      ),
    );
  }

  Widget buildButtonForm(BuildContext context, final locations) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          TextOnlyButton(
              buttonTitle: isLoading ? 'Loading...' : 'Confirm',
              onPressed: () {
                _saveField(context, locations);
              },
              isMain: true,
              borderRadius: 12),
          const SizedBox(
            height: 10,
          ),
          TextOnlyButton(
              buttonTitle: 'Cancel',
              onPressed: () {
                Provider.of<FieldProvider>(context, listen: false)
                    .resetLocation();
                Navigator.pop(context);
              },
              isMain: false,
              borderRadius: 12)
        ],
      ),
    );
  }

  Widget buildTopChip() {
    return Container(
      width: 50,
      height: 5,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(32)),
    );
  }
}
