import 'package:flutter/material.dart';
import 'package:vhack_client/model/weather_entity.dart';
import 'package:vhack_client/presentation/components/card/weather/hourly_card.dart';

class WeatherHourlyScreen extends StatelessWidget {
  final List<WeatherEntity> hourly;
  const WeatherHourlyScreen({super.key, required this.hourly});

  @override
  Widget build(BuildContext context) {
    return buildListHour();
  }

  Widget buildListHour() {
    return ListView.builder(
      itemCount: hourly.length,
      itemBuilder: (context, index) {
        return HourlyCard(weatherEntity: hourly[index]);
      },
    );
  }
}
