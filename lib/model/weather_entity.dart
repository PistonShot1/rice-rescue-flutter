import 'package:equatable/equatable.dart';

import '../shared/constant/custom_string.dart';

class WeatherEntity extends Equatable {
  final String? weatherLocation;
  final double? weatherTemp;
  final String? weatherIcon;
  final String? weatherCondition;
  final int? weatherHumidity;
  final String? weatherTime;
  final int? avgweatherHumidity;

  WeatherEntity(
      {this.weatherLocation,
      this.weatherTemp,
      this.weatherIcon,
      this.weatherCondition,
      this.weatherHumidity,
      this.weatherTime,
      this.avgweatherHumidity});

  factory WeatherEntity.fromJson(Map<String, dynamic> json) {
    return WeatherEntity(
        weatherLocation: json['location']['name'] ?? 'Ohaio',
        weatherTemp: json['current']['temp_c'] ?? 0.0,
        weatherIcon:
            json['current']['condition']['icon'] ?? CustomString.niggaURL,
        weatherCondition: json['current']['condition']['text'] ?? 'null',
        weatherHumidity: json['current']['humidity'] ?? 0,
        weatherTime: json['location']['localtime']);
  }

  factory WeatherEntity.fromJsonForecastHourly(Map<String, dynamic> json) {
    return WeatherEntity(
        weatherTemp: json['temp_c'] ?? 0.0,
        weatherIcon: json['condition']['icon'] ?? CustomString.niggaURL,
        weatherCondition: json['condition']['text'] ?? 'null',
        weatherHumidity: json['humidity'] ?? 0,
        weatherTime: json['time']);
  }

  factory WeatherEntity.fromJsonForecastDayly(Map<String, dynamic> json) {
    return WeatherEntity(
        weatherTemp: json['day']['avgtemp_c'] ?? 0.0,
        weatherIcon: json['day']['condition']['icon'] ?? CustomString.niggaURL,
        weatherCondition: json['day']['condition']['text'] ?? 'null',
        avgweatherHumidity: json['day']['avghumidity'] ?? 0,
        weatherTime: json['date']);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        weatherTemp,
        weatherIcon,
        weatherCondition,
        weatherHumidity,
        weatherTime,
        avgweatherHumidity
      ];
}
