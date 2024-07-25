import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vhack_client/features/auth/presentation/screen/login-screen.dart';
import 'package:vhack_client/features/auth/presentation/screen/register-screen.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';

import '../../../../presentation/components/button/text_button.dart';
import '../../../../shared/constant/custom_textstyle.dart';

class CredentialScreen extends StatefulWidget {
  const CredentialScreen({super.key});

  @override
  State<CredentialScreen> createState() => _CredentialScreenState();
}

class _CredentialScreenState extends State<CredentialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.getBackgroundColor(context),
      appBar: AppBar(
        backgroundColor: CustomColor.getBackgroundColor(context),
        elevation: 0.5,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/PaddyX.svg',
              height: 100,
              width: 100,
            ),
            const SizedBox(
              height: 40,
            ),
            buildWelcome(),
            const SizedBox(
              height: 40,
            ),
            buildButton(),
            const SizedBox(
              height: 20,
            ),
            buildButtom()
          ],
        ),
      ),
    );
  }

  Widget buildWelcome() => Column(
        children: [
          Text(
            'Welcome',
            style: CustomTextStyle.getTitleStyle(
                context, 18, CustomColor.getTertieryColor(context)),
            textAlign: TextAlign.center,
          ),
          Text(
            'Create an account and anhdsakdsadasdasd',
            style: CustomTextStyle.getSubTitleStyle(
                context, 12, CustomColor.getTertieryColor(context)),
            textAlign: TextAlign.center,
          )
        ],
      );

  Widget buildButton() => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: TextOnlyButton(
            buttonTitle: 'Getting Started',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RegisterScreen(),
              ));
            },
            isMain: true,
            borderRadius: 12),
      );

  Widget buildButtom() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Already have an account ?',
            style: CustomTextStyle.getTitleStyle(context, 12, Colors.grey),
          ),
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ));
            },
            child: Text(
              'Log In',
              style: CustomTextStyle.getUnderlineStyle(
                  context, 12, CustomColor.getSecondaryColor(context)),
            ),
          )
        ],
      );
}
