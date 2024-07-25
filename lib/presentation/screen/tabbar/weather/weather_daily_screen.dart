import 'package:flutter/material.dart';
import 'package:vhack_client/model/weather_entity.dart';
import 'package:vhack_client/presentation/components/card/weather/daily_card.dart';

class WeatherDailyScreen extends StatelessWidget {
  final List<WeatherEntity> dailys;
  const WeatherDailyScreen({super.key, required this.dailys});

  @override
  Widget build(BuildContext context) {
    return buildListDaily();
  }

  Widget buildListDaily() {
    return ListView.builder(
      itemCount: dailys.length,
      itemBuilder: (context, index) {
        return DailyCard(weatherEntity: dailys[index]);
      },
    );
  }
}
