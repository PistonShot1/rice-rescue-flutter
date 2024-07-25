import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:vhack_client/controller/service/weather/weather_service.dart';
import 'package:vhack_client/model/weather_entity.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';

import '../../../../model/location_entity.dart';

part 'daily_event.dart';
part 'daily_state.dart';

class DailyBloc extends Bloc<DailyEvent, DailyState> {
  DailyBloc() : super(DailyLoaded(dailys: [])) {
    on<GenerateDailyEvent>(generateDailyEvent);
  }
  final weather = WeatherService();
  FutureOr<void> generateDailyEvent(
      GenerateDailyEvent event, Emitter<DailyState> emit) async {
    try {
      emit(DailyLoading(
          loadingWidget: const CircularProgressIndicator(
        color: Colors.green,
      )));
      final response = await weather.fetchForecastDaily(event.locationEntity);
      emit(DailyLoaded(dailys: response));
    } catch (e) {
      emit(DailyFailure(failureTitle: e.toString()));
    }
  }
}
