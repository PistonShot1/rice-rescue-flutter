import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vhack_client/features/auth/domain/entity/user_entity.dart';
import 'package:vhack_client/features/auth/presentation/cubit/credential/credential_cubit.dart';
import 'package:vhack_client/presentation/components/button/icon_text_button.dart';
import 'package:vhack_client/presentation/components/button/text_button.dart';
import 'package:vhack_client/presentation/components/textfield/desc_textfield.dart';
import 'package:vhack_client/presentation/components/textfield/input_textfield.dart';
import 'package:vhack_client/presentation/components/textfield/number_textfield.dart';
import 'package:vhack_client/presentation/screen/util/integration/tutorial_screen.dart';
import 'package:vhack_client/shared/constant/custom_appbar.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';
import 'package:vhack_client/shared/constant/custom_snackbar.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';

import '../../../../presentation/components/dropdown/my_dropdown.dart';
import '../cubit/auth/auth_cubit.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController tcEmail = TextEditingController();

  final TextEditingController tcPassword = TextEditingController();
  final TextEditingController tcName = TextEditingController();

  final TextEditingController tcAge = TextEditingController();
  final TextEditingController tcDesc = TextEditingController();
  final TextEditingController tcRole = TextEditingController();

  String? selectedExp;
  String? selectedType;

  List<String> exps = ['Beginner', 'Expert'];
  List<String> types = ['Worker', 'Owner'];

  bool isLoading = false;
  bool isVisible = true;

  /*const { userEmail,
        userPassword,
        userName,
        userAge,
        userDesc,
        userType,
        userRole,
        userExp } = req.body;*/

  void register() {
    setState(() {
      isLoading = true;
    });
    BlocProvider.of<CredentialCubit>(context)
        .signUp(
      userEntity: UserEntity(
        userEmail: tcEmail.text,
        userPassword: tcPassword.text,
        userName: tcName.text,
        userAge: int.tryParse(tcAge.text),
        userDesc: tcDesc.text,
        userType: selectedType,
        userRole: tcRole.text,
        userExp: selectedExp,
      ),
    )
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  void handleVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  void dispose() {
    tcEmail.dispose();
    tcPassword.dispose();
    tcAge.dispose();
    tcDesc.dispose();
    tcRole.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildBlocContent();
  }

  Widget buildBlocContent() => BlocConsumer<CredentialCubit, CredentialState>(
        listener: (context, creState) {
          if (creState is CredentialSuccess) {
            BlocProvider.of<AuthCubit>(context).getUserDetail(context: context);
          }
        },
        builder: (context, creState) {
          if (creState is CredentialSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return TutorailScreen(
                      isFromWelcomeExp: true, userID: authState.userID);
                }

                return buildContent();
              },
            );
          }
          return buildContent();
        },
      );

  Widget buildContent() => Scaffold(
      backgroundColor: CustomColor.getBackgroundColor(context),
      appBar: CustomAppBar.BuildMainAppBar(context, false),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: buildHeader(context),
          ),
          buildSpace(),
          SliverToBoxAdapter(
            child: buildCredentialForm(),
          ),
          buildSpace(),
          SliverToBoxAdapter(
            child: buildDetailForm(),
          ),
          buildSpace(),
          SliverToBoxAdapter(
            child: buildButton(),
          )
        ],
      ));

  Widget buildHeader(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Join Us & Rescue \nYour Paddy',
              style: CustomTextStyle.getTitleStyle(
                  context, 24, CustomColor.getTertieryColor(context)),
            ),
            Text(
              'For paddy care from seed to harvest.',
              style: CustomTextStyle.getTitleStyle(
                  context, 12, CustomColor.getSecondaryColor(context)),
            ),
          ],
        ),
      );

  Widget buildCredentialForm() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            InputTextField(
                tcInput: tcName, tcTitle: 'Full Name', tcIcon: Icons.person),
            const SizedBox(
              height: 10,
            ),
            InputTextField(
                tcInput: tcEmail, tcTitle: 'Email', tcIcon: Icons.email),
            const SizedBox(
              height: 10,
            ),
            buildPasswordField(context)
          ],
        ),
      );

  Widget buildDetailForm() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tell us about you...',
              style: CustomTextStyle.getTitleStyle(
                  context, 24, CustomColor.getTertieryColor(context)),
            ),
            const SizedBox(
              height: 10,
            ),
            NumberTextField(
                tcInput: tcAge, tcTitle: 'Age', tcIcon: Icons.numbers_outlined),
            const SizedBox(
              height: 10,
            ),
            InputTextField(
                tcInput: tcDesc,
                tcTitle: 'Describe Yourself',
                tcIcon: Icons.person_outline),
            const SizedBox(
              height: 10,
            ),
            InputTextField(
                tcInput: tcRole,
                tcTitle: 'What do you work as (e.g. paddy farmer)',
                tcIcon: Icons.work_outline),
            const SizedBox(
              height: 10,
            ),
            MyDropDown(
                inputs: types,
                selectedInput: selectedType,
                onChanged: (value) {
                  setState(() {
                    selectedType = value;
                  });
                },
                dropdownTitle: 'Your Type'),
            const SizedBox(
              height: 10,
            ),
            MyDropDown(
                inputs: exps,
                selectedInput: selectedExp,
                onChanged: (value) {
                  setState(() {
                    selectedExp = value;
                  });
                },
                dropdownTitle: 'Your Experience')
          ],
        ),
      );

  Widget buildButton() => Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: CustomColor.getSecondaryColor(context),
              ),
            )
          : TextOnlyButton(
              buttonTitle: 'Create Account',
              onPressed: () {
                if (tcName.text.isNotEmpty &&
                    tcEmail.text.isNotEmpty &&
                    tcPassword.text.isNotEmpty &&
                    tcAge.text.isNotEmpty &&
                    tcDesc.text.isNotEmpty &&
                    tcRole.text.isNotEmpty) {
                  register();
                } else {
                  SnackBarUtil.showSnackBar(
                      'Please fill in all fields.', Colors.red);
                }
              },
              isMain: true,
              borderRadius: 12));

  Widget buildSpace() => const SliverToBoxAdapter(
        child: SizedBox(height: 20),
      );

  Widget buildPasswordField(
    BuildContext context,
  ) {
    return TextField(
      controller: tcPassword,
      obscureText: isVisible,
      keyboardType: TextInputType.text,
      cursorColor: CustomColor.getSecondaryColor(context),
      style: CustomTextStyle.getTitleStyle(
          context, 15, CustomColor.getTertieryColor(context)),
      decoration: InputDecoration(
          hintText: 'Password',
          hintStyle: CustomTextStyle.getSubTitleStyle(context, 15, Colors.grey),
          prefixIcon: Icon(
            Icons.lock_outline,
            color: CustomColor.getSecondaryColor(context),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              handleVisibility();
            },
            icon: Icon(
              isVisible ? Icons.visibility_off : Icons.visibility,
              color: CustomColor.getSecondaryColor(context),
            ),
          ),
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: CustomColor.getSecondaryColor(context), width: 2))),
    );
  }
}
