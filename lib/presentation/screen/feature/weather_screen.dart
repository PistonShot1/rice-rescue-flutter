import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:vhack_client/controller/provider/weather/current/current_bloc.dart';
import 'package:vhack_client/controller/provider/weather/daily/daily_bloc.dart';
import 'package:vhack_client/controller/provider/weather/hourly/hourly_bloc.dart';
import 'package:vhack_client/model/location_entity.dart';
import 'package:vhack_client/model/weather_entity.dart';
import 'package:vhack_client/presentation/screen/tabbar/weather/weather_daily_screen.dart';
import 'package:vhack_client/presentation/screen/tabbar/weather/weather_hourly_screen.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';
import 'package:lottie/lottie.dart';

import '../../../controller/service/location/location_service.dart';
import '../../../shared/constant/custom_textstyle.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  CurrentBloc currentBloc = CurrentBloc();
  DailyBloc dailyBloc = DailyBloc();
  HourlyBloc hourlyBloc = HourlyBloc();

  Future<void> getCurrentLocation() async {
    try {
      final location = await LocationService.currentLocation();

      debugPrint('Current Latitude ${location.latitude}');
      debugPrint('Current Longitude ${location.longitude}');
      currentBloc.add(GenerateCurrentEvent(
          locationEntity: LocationData(
              latitude: location.latitude, longitude: location.latitude)));
      dailyBloc.add(GenerateDailyEvent(
          locationEntity: LocationData(
              latitude: location.latitude, longitude: location.longitude)));
      hourlyBloc.add(GenerateHourlyEvent(
          locationEntity: LocationData(
              latitude: location.latitude, longitude: location.longitude)));
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
  }

  getWeatherIcon(WeatherEntity weatherEntity) {
    return 'https:${weatherEntity.weatherIcon}';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LocationService.currentLocation(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          LocationData locationEntity = LocationData(
              latitude: snapshot.data!.latitude,
              longitude: snapshot.data!.longitude);
          return MultiBlocProvider(providers: [
            BlocProvider(
              create: (context) => CurrentBloc()
                ..add(GenerateCurrentEvent(locationEntity: locationEntity)),
            ),
            BlocProvider(
              create: (context) => DailyBloc()
                ..add(GenerateDailyEvent(locationEntity: locationEntity)),
            ),
            BlocProvider(
              create: (context) => HourlyBloc()
                ..add(GenerateHourlyEvent(locationEntity: locationEntity)),
            )
          ], child: buildContent());
        } else {
          return Scaffold(
            backgroundColor: CustomColor.getBackgroundColor(context),
            body: Center(
              child: CircularProgressIndicator(
                color: CustomColor.getSecondaryColor(context),
              ),
            ),
          );
        }
      },
    );
  }

  Widget buildContent() {
    return Scaffold(
      backgroundColor: CustomColor.getBackgroundColor(context),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: CustomColor.getBackgroundColor(context),
          ),
          child: DefaultTabController(
            length: 2,
            child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverToBoxAdapter(child: buildBlocCurrentWeather()),
                    buildSilverAppBar()
                  ];
                },
                body: TabBarView(
                  children: [buildBlocHourlyWeather(), buildBlocDailyWeather()],
                )),
          ),
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Scaffold(
      backgroundColor: CustomColor.getBackgroundColor(context),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          height: 300,
          decoration: BoxDecoration(
              border: Border.all(color: CustomColor.getSecondaryColor(context)),
              borderRadius: BorderRadius.circular(12),
              color: CustomColor.getPrimaryColor(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.network(
                  'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json',
                  height: 100,
                  width: 100),
              Text(
                'Loading fetching weather',
                style: CustomTextStyle.getTitleStyle(
                    context, 21, CustomColor.getTertieryColor(context)),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBlocCurrentWeather() {
    return BlocBuilder<CurrentBloc, CurrentState>(
      builder: (context, state) {
        if (state is CurrentLoaded) {
          return buildCurrentWeather(state.currentWeather);
        }
        if (state is CurrentFailure) {
          return Text(
            state.failureTitle,
            style: CustomTextStyle.getTitleStyle(
                context, 18, CustomColor.getSecondaryColor(context)),
          );
        }
        return const SizedBox(
            height: 300, child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget buildCurrentWeather(WeatherEntity weatherEntity) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: CustomColor.getTertieryColor(context),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    weatherEntity.weatherLocation!,
                    style: CustomTextStyle.getTitleStyle(
                        context, 18, CustomColor.getTertieryColor(context)),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(50),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                  color: CustomColor.getSecondaryColor(context), width: 5)),
          child: Column(
            children: [
              Image.network(
                getWeatherIcon(weatherEntity),
                fit: BoxFit.cover,
                height: 60,
              ),
              Text(weatherEntity.weatherTemp.toString(),
                  style: CustomTextStyle.getTitleStyle(
                      context, 50, CustomColor.getTertieryColor(context))),
              Text(
                'Humidity: ${weatherEntity.weatherHumidity.toString()}%',
                style: CustomTextStyle.getSubTitleStyle(
                    context, 15, CustomColor.getTertieryColor(context)),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildBlocHourlyWeather() {
    return BlocBuilder<HourlyBloc, HourlyState>(
      builder: (context, state) {
        if (state is HourlyLoaded) {
          return WeatherHourlyScreen(
            hourly: state.hourlys,
          );
        }
        if (state is HourlyFailure) {
          return Center(
            child: Text(state.failureTitle,
                style: CustomTextStyle.getTitleStyle(
                  context,
                  18,
                  CustomColor.getSecondaryColor(context),
                )),
          );
        }
        if (state is HourlyLoading) {
          return Center(child: state.loadingWidget);
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildBlocDailyWeather() {
    return BlocBuilder<DailyBloc, DailyState>(
      builder: (context, state) {
        if (state is DailyLoaded) {
          return WeatherDailyScreen(
            dailys: state.dailys,
          );
        }
        if (state is DailyFailure) {
          return Center(
            child: Text(state.failureTitle,
                style: CustomTextStyle.getTitleStyle(
                  context,
                  18,
                  CustomColor.getSecondaryColor(context),
                )),
          );
        }
        if (state is DailyLoading) {
          return Center(child: state.loadingWidget);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildSilverAppBar() {
    return SliverAppBar(
      pinned: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: true,
      shape: Border(
          bottom: BorderSide(
              color: const Color(0xFFAAAAAA).withOpacity(1), width: 1)),
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: TabBar(
              unselectedLabelColor: Colors.grey,
              labelColor: Theme.of(context).colorScheme.tertiary,
              indicatorColor: CustomColor.getSecondaryColor(context),
              indicatorWeight: 5,
              tabs: [
                Tab(
                  child: Text(
                    'Hourly',
                    style: CustomTextStyle.getTitleStyle(
                        context, 15, CustomColor.getTertieryColor(context)),
                  ),
                ),
                Tab(
                  child: Text(
                    'Days',
                    style: CustomTextStyle.getTitleStyle(
                        context, 15, CustomColor.getTertieryColor(context)),
                  ),
                ),
              ])),
    );
  }
}
