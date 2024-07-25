import 'dart:convert';

import 'package:vhack_client/features/field/data/model/field_model.dart';
import 'package:vhack_client/model/crop_entity.dart';
import 'package:vhack_client/model/weather_entity.dart';
import 'package:http/http.dart' as http;
import 'package:vhack_client/shared/constant/custom_string.dart';
import '../../../model/location_entity.dart';

abstract class WeatherRemoteDatabase {
  Future<List<WeatherEntity>> fetchForecastHourly(LocationData locationEntity);
  Future<List<WeatherEntity>> fetchForecastDaily(LocationData locationEntity);
  Future<WeatherEntity> fetchCurrent(LocationData locationEntity);
}

class WeatherService extends WeatherRemoteDatabase {
  @override
  Future<WeatherEntity> fetchCurrent(LocationData locationEntity) async {
    final response = await http.get(Uri.parse(
        'https://api.weatherapi.com/v1/current.json?key=${CustomString.weatherKey}&q=${locationEntity.latitude},${locationEntity.longitude}&days=7&aqi=no'));
    final jsonData = jsonDecode(response.body);
    return WeatherEntity.fromJson(jsonData);
  }

  @override
  Future<List<WeatherEntity>> fetchForecastDaily(
      LocationData locationEntity) async {
    List<WeatherEntity> dailys = [];
    final response = await http.get(Uri.parse(
        'https://api.weatherapi.com/v1/forecast.json?key=${CustomString.weatherKey}&q=q=${locationEntity.latitude},${locationEntity.longitude}&days=7&aqi=no&alerts=no'));
    final jsonData = jsonDecode(response.body);
    for (var eachDay in jsonData['forecast']['forecastday']) {
      final days = WeatherEntity.fromJsonForecastDayly(eachDay);
      dailys.add(days);
    }

    return dailys;
  }

  @override
  Future<List<WeatherEntity>> fetchForecastHourly(
      LocationData locationEntity) async {
    List<WeatherEntity> hourlys = [];
    final response = await http.get(Uri.parse(
        'https://api.weatherapi.com/v1/forecast.json?key=${CustomString.weatherKey}&q=q=${locationEntity.latitude},${locationEntity.longitude}&days=7&aqi=no&alerts=no'));
    final jsonData = jsonDecode(response.body);
    for (var eachHour in jsonData['forecast']['forecastday'][0]['hour']) {
      final hours = WeatherEntity.fromJsonForecastHourly(eachHour);
      hourlys.add(hours);
    }

    return hourlys;
  }
}
