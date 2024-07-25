import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../model/weather_entity.dart';
import '../../../../shared/constant/custom_color.dart';
import '../../../../shared/constant/custom_date.dart';
import '../../../../shared/constant/custom_textstyle.dart';

class DailyCard extends StatelessWidget {
  final WeatherEntity weatherEntity;
  const DailyCard({super.key, required this.weatherEntity});

  getWeatherIcon() {
    return 'https:${weatherEntity.weatherIcon}';
  }

  bool checkNow(WeatherEntity weatherEntity) {
    String dateTimeAPI = weatherEntity.weatherTime!;
    DateTime dtAPI = DateTime.parse(dateTimeAPI);
    DateTime dtNow = DateTime.now();
    String dfAPI = DateFormat('HH').format(dtAPI);
    String dfNow = DateFormat('HH').format(dtNow);

    if (dfAPI == dfNow) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildDailyCard(context);
  }

  Widget buildDailyCard(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Container(
            color: checkNow(weatherEntity)
                ? CustomColor.getSecondaryColor(context).withOpacity(0.5)
                : Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  ConvertDate.convertToDateWeather(
                      weatherEntity: weatherEntity),
                  style: CustomTextStyle.getTitleStyle(
                      context, 15, CustomColor.getTertieryColor(context)),
                ),
                Image.network(getWeatherIcon()),
                Text(
                  '${weatherEntity.weatherTemp!.toString()} C',
                  style: CustomTextStyle.getTitleStyle(
                      context, 15, CustomColor.getTertieryColor(context)),
                ),
              ],
            ),
          ),
        ),
        Divider(
          color: CustomColor.getSecondaryColor(context),
          thickness: 0.5,
        )
      ],
    );
  }
}
