import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:vhack_client/controller/provider/crop/crop_provider.dart';
import 'package:vhack_client/controller/provider/field/type_field_provider.dart';
import 'package:vhack_client/controller/provider/metric_provider.dart';
import 'package:vhack_client/features/auth/presentation/screen/credential_screen.dart';
import 'package:vhack_client/features/auth/presentation/screen/login-screen.dart';
import 'package:vhack_client/features/crop/presentation/cubit/crop/crop_cubit.dart';
import 'package:vhack_client/features/field/domain/usecase/getfields_uc.dart';
import 'package:vhack_client/features/field/presentation/cubit/field/field_cubit.dart';
import 'package:vhack_client/features/field/presentation/cubit/single_field/single_field_cubit.dart';
import 'package:vhack_client/features/field/presentation/provider/field_provider.dart';
import 'package:vhack_client/features/job/presentation/cubit/job/job_cubit.dart';
import 'package:vhack_client/features/job/presentation/cubit/single_job/single_job_cubit.dart';
import 'package:vhack_client/features/machine/presentation/cubit/machine/machine_cubit.dart';
import 'package:vhack_client/features/team/presentation/cubit/forum/forum_cubit.dart';
import 'package:vhack_client/features/team/presentation/cubit/team/single_team/single_team_cubit.dart';
import 'package:vhack_client/features/team/presentation/cubit/team/team_cubit.dart';
import 'package:vhack_client/presentation/screen/bridge_screen.dart';
import 'package:vhack_client/presentation/screen/util/welcome/welcome_screen.dart';
import 'package:vhack_client/shared/constant/custom_snackbar.dart';
import 'package:vhack_client/shared/theme/dark_theme.dart';
import 'package:vhack_client/shared/theme/light_theme.dart';
import 'package:provider/provider.dart';
import 'package:vhack_client/shared/util/services/fcm_service.dart';
import 'features/auth/presentation/cubit/credential/credential_cubit.dart';
import 'features/auth/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'features/auth/presentation/cubit/user/user_cubit.dart';
import 'injection_container.dart' as di;

import 'features/auth/presentation/cubit/auth/auth_cubit.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage remoteMessage) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${remoteMessage.messageId}");
  print("Handling a background title: ${remoteMessage.notification!.title}");
}

void main() async {
  di.init();
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await Firebase.initializeApp();
  await FCMService().initNotification();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => CropProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => TypeFieldProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => FieldProvider(),
          ),
          BlocProvider<CredentialCubit>(
              create: (context) => di.sl<CredentialCubit>()),
          BlocProvider<AuthCubit>(
            create: (context) =>
                di.sl<AuthCubit>()..getUserDetail(context: context),
          ),
          BlocProvider<UserCubit>(
            create: (context) => di.sl<UserCubit>(),
          ),
          BlocProvider<GetSingleUserCubit>(
            create: (context) => di.sl<GetSingleUserCubit>(),
          ),
          BlocProvider<FieldCubit>(
            create: (context) => di.sl<FieldCubit>(),
          ),
          BlocProvider<SingleFieldCubit>(
            create: (context) => di.sl<SingleFieldCubit>(),
          ),
          BlocProvider<JobCubit>(
            create: (context) => di.sl<JobCubit>(),
          ),
          BlocProvider<SingleJobCubit>(
            create: (context) => di.sl<SingleJobCubit>(),
          ),
          BlocProvider<MachineCubit>(
            create: (context) => di.sl<MachineCubit>(),
          ),
          BlocProvider<CropCubit>(
            create: (context) => di.sl<CropCubit>(),
          ),
          BlocProvider<ForumCubit>(
            create: (context) => di.sl<ForumCubit>(),
          ),
          BlocProvider<TeamCubit>(
            create: (context) => di.sl<TeamCubit>(),
          ),
          BlocProvider<SingleTeamCubit>(
            create: (context) => di.sl<SingleTeamCubit>(),
          ),
          ChangeNotifierProvider(
            create: (context) => MetricProvider(),
          ),
        ],
        child: buildMaterialApp(),
      );

  MaterialApp buildMaterialApp() => MaterialApp(
      scaffoldMessengerKey: SnackBarUtil.messengerKey,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            print('From Main: $state.userID');
            if (state.userID.isEmpty) {
              return LoginScreen();
            }
            return BridgeScreen(
              userID: state.userID,
            );
          }
          return LoginScreen();
        },
      ));
}

//WelcomeScreen()
