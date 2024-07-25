import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:vhack_client/controller/service/weather/weather_service.dart';
import 'package:vhack_client/model/weather_entity.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';

import '../../../../model/location_entity.dart';

part 'hourly_event.dart';
part 'hourly_state.dart';

class HourlyBloc extends Bloc<HourlyEvent, HourlyState> {
  HourlyBloc() : super(HourlyLoaded(hourlys: [])) {
    on<GenerateHourlyEvent>(generateHourlyEvent);
  }
  final weather = WeatherService();
  FutureOr<void> generateHourlyEvent(
      GenerateHourlyEvent event, Emitter<HourlyState> emit) async {
    try {
      emit(HourlyLoading(
        loadingWidget: const CircularProgressIndicator(color: Colors.green),
      ));
      final response = await weather.fetchForecastHourly(event.locationEntity);
      emit(HourlyLoaded(hourlys: response));
    } catch (e) {
      emit(HourlyFailure(failureTitle: e.toString()));
    }
  }
}
