import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:vhack_client/features/auth/domain/entity/user_entity.dart';
import 'package:vhack_client/features/field/presentation/screen/history_field_screen.dart';
import 'package:vhack_client/features/job/presentation/screen/job_screen.dart';
import 'package:vhack_client/presentation/screen/feature/aichat_screen.dart';
import 'package:vhack_client/features/crop/presentation/screen/analyze_screen.dart';
import 'package:vhack_client/presentation/screen/build/home_screen.dart';
import 'package:vhack_client/presentation/screen/build/pest_screen.dart';
import 'package:vhack_client/presentation/screen/build/profile_screen.dart';
import 'package:vhack_client/features/field/presentation/screen/first_field_screen.dart';

import '../../controller/provider/weather/current/current_bloc.dart';
import '../../controller/provider/weather/daily/daily_bloc.dart';
import '../../controller/provider/weather/hourly/hourly_bloc.dart';
import '../../controller/service/location/location_service.dart';
import '../../features/auth/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import '../../model/location_entity.dart';
import '../../shared/constant/custom_color.dart';

class BridgeScreen extends StatefulWidget {
  final String? userID;
  const BridgeScreen({super.key, this.userID});

  @override
  State<BridgeScreen> createState() => _BridgeScreenState();
}

class _BridgeScreenState extends State<BridgeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    BlocProvider.of<GetSingleUserCubit>(context)
        .getSingleUser(userEntity: UserEntity(userID: widget.userID));
    super.initState();
  }

  CurrentBloc currentBloc = CurrentBloc();
  DailyBloc dailyBloc = DailyBloc();
  HourlyBloc hourlyBloc = HourlyBloc();

  Widget selectPages(int index, UserEntity userEntity) {
    switch (index) {
      case 0:
        return HomeScreen(
          userEntity: userEntity,
        );
      case 1:
        return HistoryFieldScreen(
          userEntity: userEntity,
        );
      case 2:
        return JobScreen(
          userEntity: userEntity,
        );
      case 3:
        return ProfileScreen(userEntity: userEntity);
      default:
        return Container(); // Return a default widget if index is out of range
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
      builder: (context, state) {
        if (state is GetSingleUserLoaded) {
          UserEntity userEntity = state.userEntity;
          return Scaffold(
              backgroundColor: CustomColor.getBackgroundColor(context),
              bottomNavigationBar: buildBottomNavbar(),
              body: selectPages(_selectedIndex, userEntity));
        }
        if (state is GetSingleUserFailure) {
          return Center(child: Text(state.failureTitle));
        }
        return Container();
      },
    );
  }

  Widget buildBottomNavbar() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(64),
            color: CustomColor.getPrimaryColor(context)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: GNav(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              padding: const EdgeInsets.all(16),
              backgroundColor: Colors.transparent,
              gap: 8,
              activeColor:
                  CustomColor.getSecondaryColor(context).withOpacity(1),
              color: Colors.grey,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              tabs: const [
                GButton(
                  icon: Icons.home_outlined,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.area_chart_outlined,
                  text: 'Field',
                ),
                GButton(
                  icon: Icons.workspaces_outline,
                  text: 'Job',
                ),
                GButton(
                  icon: Icons.person_2_outlined,
                  text: 'Profile',
                ),
              ]),
        ),
      ),
    );
  }
}
