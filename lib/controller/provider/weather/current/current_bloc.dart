import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:vhack_client/controller/service/location/location_service.dart';
import 'package:vhack_client/controller/service/weather/weather_service.dart';
import 'package:vhack_client/model/location_entity.dart';
import 'package:vhack_client/model/weather_entity.dart';

part 'current_event.dart';
part 'current_state.dart';

class CurrentBloc extends Bloc<CurrentEvent, CurrentState> {
  CurrentBloc() : super(CurrentInitial()) {
    on<GenerateCurrentEvent>(generateCurrentEvent);
  }

  final weather = WeatherService();

  FutureOr<void> generateCurrentEvent(
      GenerateCurrentEvent event, Emitter<CurrentState> emit) async {
    try {
      Position position = await LocationService.currentLocation();

      final response = await weather.fetchCurrent(LocationData(
          latitude: position.latitude, longitude: position.longitude));
      emit(CurrentLoaded(currentWeather: response));
    } catch (e) {
      emit(CurrentFailure(failureTitle: e.toString()));
    }
  }
}
