part of 'hourly_bloc.dart';

@immutable
sealed class HourlyState {}

final class HourlyInitial extends HourlyState {}

final class HourlyLoaded extends HourlyState {
  final List<WeatherEntity> hourlys;
  HourlyLoaded({required this.hourlys});
}

final class HourlyFailure extends HourlyState {
  final String failureTitle;
  HourlyFailure({required this.failureTitle});
}

final class HourlyLoading extends HourlyState {
  final Widget loadingWidget;
  HourlyLoading({required this.loadingWidget});
}
