import 'package:flutter/material.dart';
import 'package:vhack_client/presentation/components/button/text_button.dart';
import 'package:vhack_client/presentation/components/dropdown/my_dropdown.dart';
import 'package:vhack_client/features/field/presentation/screen/first_field_screen.dart';
import 'package:vhack_client/presentation/screen/util/integration/tutorial_screen.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';

class WelcomeExpScreen extends StatefulWidget {
  const WelcomeExpScreen({super.key});

  @override
  State<WelcomeExpScreen> createState() => _WelcomeExpScreenState();
}

class _WelcomeExpScreenState extends State<WelcomeExpScreen> {
  String selectedYear = '1 Year';
  List<String> years = ['1 Year', '3 Years', 'More than 3 Years'];

  List listButton = [
    ['Beginner', true],
    ['Expert', false]
  ];

  void _selectedButton(int index) {
    setState(() {
      for (int i = 0; i < listButton.length; i++) {
        listButton[i][1] = false;
      }

      listButton[index][1] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildHeader(),
              const SizedBox(
                height: 20,
              ),
              buildDropDown(),
              const SizedBox(
                height: 20,
              ),
              buildConfirmButton()
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() => AppBar(
        backgroundColor: CustomColor.getSecondaryColor(context),
        elevation: 0.5,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Experience',
          style: CustomTextStyle.getTitleStyle(
              context, 18, CustomColor.getWhiteColor(context)),
        ),
      );

  Widget buildHeader() => Padding(
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: Column(
          children: [
            Text(
              'How experience are you in paddy farming?',
              style: CustomTextStyle.getSubTitleStyle(
                  context, 15, CustomColor.getTertieryColor(context)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Image.asset('assets/welcome/welcome.png'),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: listButton.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextOnlyButton(
                      buttonTitle: listButton[index][0],
                      onPressed: () {
                        _selectedButton(index);
                      },
                      isMain: listButton[index][1] ? true : false,
                      borderRadius: 12),
                );
              },
            )
          ],
        ),
      );

  Widget buildDropDown() {
    if (listButton[0][1]) {
      return buildDisableDropDown();
    } else {
      return buildAbleDropDown();
    }
  }

  Widget buildAbleDropDown() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: IgnorePointer(
          ignoring: listButton[0][1] == true,
          child: MyDropDown(
            dropdownTitle: 'Experience',
            inputs: years,
            selectedInput: selectedYear,
            onChanged: (value) {
              setState(() {
                selectedYear = value;
              });
            },
          ),
        ),
      );

  Widget buildDisableDropDown() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.circular(12),
              color: CustomColor.getPrimaryColor(context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Year',
                style:
                    CustomTextStyle.getSubTitleStyle(context, 15, Colors.grey),
              ),
              const Icon(
                Icons.arrow_drop_down,
                color: Colors.grey,
              )
            ],
          ),
        ),
      );

  Widget buildConfirmButton() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextOnlyButton(
            buttonTitle: 'Confirm',
            onPressed: () {},
            isMain: true,
            borderRadius: 12),
      );
}
