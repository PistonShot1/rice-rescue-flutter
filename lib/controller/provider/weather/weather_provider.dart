import 'package:flutter/material.dart';
import 'package:vhack_client/model/weather_entity.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherEntity? _currentWeather;
  WeatherEntity? get currentWeather => _currentWeather;

  List<WeatherEntity>? _forecastHourly;
  List<WeatherEntity>? get forecastHourly => _forecastHourly;

  List<WeatherEntity>? _forecastDaily;
  List<WeatherEntity>? get forecastDaily => _forecastDaily;

  Future<void> getCurrentWeather() async {
    try {} catch (e) {}
  }
}
