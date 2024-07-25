part of 'current_bloc.dart';

@immutable
sealed class CurrentState {}

final class CurrentInitial extends CurrentState {}

final class CurrentLoaded extends CurrentState {
  final WeatherEntity currentWeather;
  CurrentLoaded({required this.currentWeather});
}

final class CurrentFailure extends CurrentState {
  final String failureTitle;
  CurrentFailure({required this.failureTitle});
}
