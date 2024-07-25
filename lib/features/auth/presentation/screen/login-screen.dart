import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vhack_client/features/auth/presentation/screen/register-screen.dart';
import 'package:vhack_client/presentation/components/button/text_button.dart';
import 'package:vhack_client/presentation/components/textfield/input_textfield.dart';
import 'package:vhack_client/shared/constant/custom_appbar.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';

import '../../../../presentation/screen/bridge_screen.dart';
import '../../../../shared/constant/custom_color.dart';
import '../../domain/entity/user_entity.dart';
import '../cubit/auth/auth_cubit.dart';
import '../cubit/credential/credential_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController tcEmail = TextEditingController();
  final TextEditingController tcPassword = TextEditingController();
  bool isLoading = false;

  void signIn() {
    setState(() {
      isLoading = true;
    });
    BlocProvider.of<CredentialCubit>(context)
        .signIn(
            userEntity: UserEntity(
                userEmail: tcEmail.text, userPassword: tcPassword.text))
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    tcEmail.clear();
    tcPassword.clear();
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
                  return BridgeScreen(
                    userID: authState.userID,
                  );
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
      appBar: AppBar(
        backgroundColor: CustomColor.getBackgroundColor(context),
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildTitle(),
                    const SizedBox(
                      height: 40,
                    ),
                    buildCard(),
                    const SizedBox(
                      height: 40,
                    ),
                    buildCopyright()
                  ],
                ),
              ),
            ),
          )
        ],
      ));

  Widget buildTitle() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Rice Rescue',
              style: CustomTextStyle.getTitleStyle(
                  context, 32, CustomColor.getTertieryColor(context)),
            ),
            Image.asset(
              'assets/logo.png',
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
          ],
        ),
      );

  Widget buildCard() => Container(
        height: 450,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(12),
            color: CustomColor.getPrimaryColor(context)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildHeader(context),
            const SizedBox(
              height: 40,
            ),
            buildForm(),
            const SizedBox(
              height: 40,
            ),
            buildBottom()
          ],
        ),
      );

  Widget buildHeader(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text(
              'Welcome Back',
              style: CustomTextStyle.getTitleStyle(
                  context, 24, CustomColor.getTertieryColor(context)),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Fill out the information below in order to access your account.',
              style: CustomTextStyle.getSubTitleStyle(context, 15, Colors.grey),
              textAlign: TextAlign.center,
            )
          ],
        ),
      );

  Widget buildForm() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            InputTextField(
                tcInput: tcEmail,
                tcTitle: 'zetten@gmail.com',
                tcIcon: Icons.email_outlined),
            const SizedBox(
              height: 10,
            ),
            InputTextField(
                tcInput: tcPassword,
                tcTitle: 'zetten@123',
                tcIcon: Icons.password_outlined),
          ],
        ),
      );

  Widget buildBottom() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            isLoading
                ? CircularProgressIndicator(
                    color: CustomColor.getSecondaryColor(context),
                  )
                : TextOnlyButton(
                    buttonTitle: 'Sign In',
                    onPressed: () {
                      signIn();
                    },
                    isMain: true,
                    borderRadius: 12),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Dont have an account?',
                  style:
                      CustomTextStyle.getTitleStyle(context, 12, Colors.grey),
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ));
                  },
                  child: Text(
                    'Sign Up Here',
                    style: CustomTextStyle.getUnderlineStyle(
                        context, 12, CustomColor.getSecondaryColor(context)),
                  ),
                )
              ],
            )
          ],
        ),
      );

  Widget buildCopyright() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.copyright,
            color: Colors.grey,
            size: 18,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            'Copyright',
            style: CustomTextStyle.getSubTitleStyle(context, 15, Colors.grey),
          ),
        ],
      );
}
