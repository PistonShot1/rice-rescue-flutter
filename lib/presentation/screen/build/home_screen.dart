import 'dart:developer';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:vhack_client/controller/provider/metric_provider.dart';
import 'package:vhack_client/features/field/domain/entity/field_entity.dart';
import 'package:vhack_client/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vhack_client/controller/provider/weather/daily/daily_bloc.dart';
import 'package:vhack_client/features/auth/domain/entity/user_entity.dart';
import 'package:vhack_client/features/field/data/model/field_model.dart';
import 'package:vhack_client/features/field/presentation/cubit/field/field_cubit.dart';
import 'package:vhack_client/model/weather_entity.dart';
import 'package:vhack_client/presentation/components/card/home/feature_card.dart';
import 'package:vhack_client/presentation/components/card/home/metric_card.dart';
import 'package:vhack_client/presentation/components/card/user_avatar_card.dart';
import 'package:vhack_client/presentation/components/chart/custom_slider.dart';
import 'package:vhack_client/presentation/components/chart/soil_moist_chart_home.dart';
import 'package:vhack_client/presentation/components/chart/soil_temp_chart.dart';
import 'package:vhack_client/presentation/components/dropdown/field_dropdown.dart';
import 'package:vhack_client/presentation/components/dropdown/metric_dropdown.dart';
import 'package:vhack_client/presentation/components/image/mynetwork_image.dart';
import 'package:vhack_client/presentation/screen/feature/aichat_screen.dart';
import 'package:vhack_client/features/crop/presentation/screen/analyze_screen.dart';
import 'package:vhack_client/features/machine/presentation/screen/machines_screen.dart';
import 'package:vhack_client/presentation/screen/feature/pest_detector_screen.dart';
import 'package:vhack_client/presentation/screen/feature/service_screen.dart';
import 'package:vhack_client/presentation/screen/feature/team_screen.dart';
import 'package:vhack_client/presentation/screen/util/metric/fertilization_screen.dart';
import 'package:vhack_client/presentation/screen/util/metric/soil_moisture_screen.dart';
import 'package:vhack_client/presentation/screen/util/metric/soil_temperature_screen.dart';
import 'package:vhack_client/presentation/screen/feature/weather_screen.dart';
import 'package:vhack_client/shared/constant/custom_appbar.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';
import 'package:vhack_client/shared/util/widget_data.dart';
import 'package:vhack_client/model/location_entity.dart';
import '../../../controller/service/location/location_service.dart';
import '../../../shared/constant/custom_date.dart';
import '../../components/chart/soil_temp_chart_home.dart';

class HomeScreen extends StatefulWidget {
  final UserEntity userEntity;
  const HomeScreen({super.key, required this.userEntity});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DailyBloc dailyBloc = DailyBloc();
  String selectedValue = 'Field 1';
  FieldEntity? selectedField;
  List<String> values = ['Field 1', 'Field 2', 'Field 3', 'Field 4'];

  static List listMetricReal = [
    {
      'metricID': '1',
      'metricTitle': 'Nutrients',
      'metricDesc': '1st Phase Deficiency'
    },
    {
      'metricID': '2',
      'metricTitle': 'Fertilization Phase',
      'metricDesc': '7 Days'
    },
    {'metricID': '3', 'metricTitle': 'Soil Temperature', 'metricDesc': '27 C'},
    {
      'metricID': '4',
      'metricTitle': 'Soil Moisture',
      'metricDesc': '16% at Sungai Petani'
    },
  ];

  @override
  void initState() {
    getCurrentLocation();

    super.initState();
  }

  Future<void> getCurrentLocation() async {
    try {
      final location = await LocationService.currentLocation();

      debugPrint('Current Latitude ${location.latitude}');
      debugPrint('Current Longitude ${location.longitude}');

      dailyBloc.add(GenerateDailyEvent(
          locationEntity: LocationData(
              latitude: location.latitude, longitude: location.longitude)));
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
  }

  void featureNavigation(String featureID) {
    final Map<String, Widget Function(BuildContext)> featureRoutes = {
      '1': (context) => AnalyzeScreen(
            userEntity: widget.userEntity,
          ),
      '2': (context) => AIChatScreen(),
      '3': (context) => WeatherScreen(),
      '4': (context) => MachinesScreen(userEntity: widget.userEntity),
      '5': (context) => TeamScreen(
            userEntity: widget.userEntity,
          ),
      '6': (context) => ServiceScreen()
    };

    final Widget Function(BuildContext)? selectedRoute =
        featureRoutes[featureID];
    if (selectedRoute != null) {
      Navigator.of(context).push(MaterialPageRoute(builder: selectedRoute));
    }
  }

  void metricNavigation(String metricID) {
    final Map<String, Widget Function(BuildContext)> metricRoutes = {
      '1': (context) => FertilizationScreen(),
      '2': (context) => FertilizationScreen(),
      '3': (context) => SoilTemperatureScreen(),
      '4': (context) => SoilMoistureScreen(),
    };

    final Widget Function(BuildContext)? selectedRoute = metricRoutes[metricID];
    if (selectedRoute != null) {
      Navigator.of(context).push(MaterialPageRoute(builder: selectedRoute));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.getBackgroundColor(context),
      appBar: CustomAppBar.BuildMainAppBar(context, true),
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  buildHomeHeader(context),
                  buildDivider(),
                  buildHomeOverallHealth(context),
                ],
              ),
            ),
          ),
          buildSpacer(10.0),
          buildFeatureSection(context),
          buildSpacer(10.0),
          buildMetricSection(context, false),
          buildSpacer(10.0),
          buildMetricSection(context, true),
          buildSpacer(20.0),
          buildWeatherSection(context),
        ],
      ),
    );
  }

  Widget buildHomeHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, ${widget.userEntity.userName}',
                style: CustomTextStyle.getTitleStyle(
                    context, 18, CustomColor.getTertieryColor(context)),
              ),
              Text(
                widget.userEntity.userRole!,
                style: CustomTextStyle.getSubTitleStyle(
                    context, 14, CustomColor.getTertieryColor(context)),
              )
            ],
          ),
          MyNetworkImage(
              pathURL: widget.userEntity.userAvatar!.avatarURL,
              width: 50,
              height: 50,
              radius: 60)
        ],
      ),
    );
  }

  Widget buildHomeOverallHealth(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey, width: 0.5),
          color: CustomColor.getPrimaryColor(context)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CustomColor.getSecondaryColor(context)),
                child: Center(
                  child: Text(
                    '72',
                    style: CustomTextStyle.getTitleStyle(
                        context, 15, CustomColor.getWhiteColor(context)),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Overall Health',
                      style: CustomTextStyle.getTitleStyle(
                          context, 15, CustomColor.getTertieryColor(context)),
                    ),
                    Text(
                      'Based on overall health on paddy score 85 consider good',
                      style: CustomTextStyle.getSubTitleStyle(
                          context, 12, CustomColor.getTertieryColor(context)),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildFeatureSection(BuildContext context) {
    return SliverGrid(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        final eachFeature = WidgetData.listFeatures[index];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: FeatureCard(
              eachFeature: eachFeature,
              onPressed: () {
                featureNavigation(eachFeature['featureID']);
              },
            ),
          ),
        );
      }, childCount: WidgetData.listFeatures.length),
    );
  }

  Widget buildMetricSection(BuildContext context, bool isMetrics) {
    if (!isMetrics) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Metrics',
                style: CustomTextStyle.getTitleStyle(
                  context,
                  18,
                  CustomColor.getTertieryColor(context),
                ),
              ),
              BlocProvider<FieldCubit>(
                create: (context) => di.sl<FieldCubit>()..getFields(),
                child: BlocBuilder<FieldCubit, FieldState>(
                  builder: (context, state) {
                    if (state is FieldLoaded) {
                      final myFields = state.fields
                          .where((field) =>
                              field.fieldOwnerID == widget.userEntity.userID)
                          .toList();
                      return SizedBox(
                        height: 50,
                        width: 150,
                        child: FieldDropDown(
                          fields: myFields,
                          selectedField: selectedField,
                          onChanged: (value) {
                            final metricProvider = Provider.of<MetricProvider>(
                                context,
                                listen: false);
                            setState(() {
                              selectedField = value;
                            });

                            metricProvider.setSelectedField(value);
                          },
                        ),
                      );
                    } else {
                      return MetricDropdown(
                        values: values,
                        selectedValue: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return Consumer<MetricProvider>(
        builder: (context, value, child) {
          if (selectedField == null) {
            return SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                final eachMetric = WidgetData.listMetric[index];
                return InkWell(
                  onTap: () {
                    metricNavigation(eachMetric['metricID']);
                  },
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: MetricCard(eachMetric: eachMetric)),
                );
              }, childCount: WidgetData.listMetric.length),
            );
          } else {
            return SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                final eachMetric = listMetricReal[index];

                if (eachMetric['metricID'] == '1' ||
                    eachMetric['metricID'] == '2') {
                  return InkWell(
                    onTap: () {
                      metricNavigation(eachMetric['metricID']);
                    },
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: buildMetricCard(true, eachMetric)),
                  );
                } else {
                  return InkWell(
                    onTap: () {
                      metricNavigation(eachMetric['metricID']);
                    },
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: buildMetricCard(false, eachMetric)),
                  );
                }
              }, childCount: listMetricReal.length),
            );
          }
        },
      );
    }
  }

  Widget buildMetricCard(bool isCircle, final eachMetric) {
    if (isCircle) {
      return buildMetricCardBar(eachMetric);
    } else {
      return buildMetricCardLine(context, eachMetric);
    }
  }

  Widget buildMetricCardLine(BuildContext context, final eachMetric) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              blurRadius: 2,
              color: Color(0x3F14181B),
              offset: Offset(0, 3),
            )
          ],
          borderRadius: BorderRadius.circular(16),
          color: CustomColor.getPrimaryColor(context)),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(eachMetric['metricTitle'],
                style: CustomTextStyle.getSubTitleStyle(
                  context,
                  15,
                  CustomColor.getTertieryColor(context),
                )),
          ],
        ),
        buildChart(eachMetric),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              eachMetric['metricID'] == '3' ? '36 C' : '28 %',
              style: CustomTextStyle.getTitleStyle(
                  context, 12, CustomColor.getTertieryColor(context)),
            ),
          ],
        )
      ]),
    );
  }

  Widget buildChart(final eachMetric) {
    if (eachMetric['metricID'] == '3') {
      return Expanded(child: SoilTempChartHome(fieldEntity: selectedField!));
    }
    if (eachMetric['metricID'] == '4') {
      return Expanded(child: SoilMoistChartHome(fieldEntity: selectedField!));
    }

    return Container();
  }

  Widget buildMetricCardBar(final eachMetric) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              blurRadius: 2,
              color: Color(0x3F14181B),
              offset: Offset(0, 3),
            )
          ],
          borderRadius: BorderRadius.circular(16),
          color: CustomColor.getPrimaryColor(context)),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(eachMetric['metricTitle'],
                style: CustomTextStyle.getSubTitleStyle(
                  context,
                  15,
                  CustomColor.getTertieryColor(context),
                )),
          ],
        ),
        buildBar(eachMetric),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              eachMetric['metricDesc'],
              style: CustomTextStyle.getTitleStyle(
                  context, 12, CustomColor.getTertieryColor(context)),
            ),
          ],
        )
      ]),
    );
  }

  Widget buildBar(final eachMetric) {
    if (eachMetric['metricID'] == '1') {
      return Consumer<MetricProvider>(
        builder: (context, value, child) {
          double nutrient = 0;
          if (value.cropNutrient == '') {
            nutrient = 0;
          } else {
            String nutrientString = value.cropNutrient.replaceAll('%', '');
            nutrient = double.parse(nutrientString);
          }

          return Expanded(
            child: CustomSlider(
              percentage: nutrient,
              lineWidth: 10,
              radius: 100,
            ),
          );
        },
      );
    }
    if (eachMetric['metricID'] == '2') {
      return const Expanded(
        child: CustomSlider(
          percentage: 10,
          lineWidth: 10,
          radius: 100,
        ),
      );
    }

    return Container();
  }

  Widget buildWeatherSection(BuildContext context) {
    return SliverToBoxAdapter(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Today Weather',
                      style: CustomTextStyle.getTitleStyle(
                          context, 18, CustomColor.getTertieryColor(context)),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => WeatherScreen(),
                        ));
                      },
                      child: Text(
                        'More',
                        style: CustomTextStyle.getTitleStyle(context, 15,
                            CustomColor.getSecondaryColor(context)),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                buildListWeatherSectionCard()
              ],
            )));
  }

  Widget buildListWeatherSectionCard() {
    return BlocConsumer<DailyBloc, DailyState>(
      bloc: dailyBloc,
      builder: (context, state) {
        if (state is DailyLoaded) {
          if (state.dailys.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(12),
                    color: CustomColor.getPrimaryColor(context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildWeatherSectionCard(state.dailys[0]),
                    buildWeatherSectionCard(state.dailys[1]),
                    buildWeatherSectionCard(state.dailys[2])
                  ],
                ),
              ),
            );
          } else {
            Text(state.dailys.length.toString());
          }
        }
        if (state is DailyFailure) {
          return Container();
        }
        return Container();
      },
      listener: (context, state) {},
    );
  }

  Widget buildWeatherSectionCard(WeatherEntity weatherEntity) {
    return Expanded(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: SvgPicture.asset(
          'assets/weather/cloud-sun.svg',
          semanticsLabel: 'Cloud-Sun',
          height: 40,
          width: 40,
        ),
        title: Text(
          ConvertDate.convertToDateWeather(weatherEntity: weatherEntity),
          style: CustomTextStyle.getSubTitleStyle(
              context, 10, CustomColor.getTertieryColor(context)),
        ),
        subtitle: Text(
          '${weatherEntity.weatherTemp!.toString()} C',
          style: CustomTextStyle.getTitleStyle(
              context, 15, CustomColor.getTertieryColor(context)),
        ),
      ),
    );
  }

  Widget buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Divider(
        color: Colors.grey,
        thickness: 0.5,
      ),
    );
  }

  Widget buildSpacer(double gap) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: gap,
      ),
    );
  }
}
