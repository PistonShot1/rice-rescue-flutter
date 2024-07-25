part of 'daily_bloc.dart';

@immutable
sealed class DailyState {}

final class DailyInitial extends DailyState {}

final class DailyLoaded extends DailyState {
  final List<WeatherEntity> dailys;
  DailyLoaded({required this.dailys});
}

final class DailyFailure extends DailyState {
  final String failureTitle;
  DailyFailure({required this.failureTitle});
}

final class DailyLoading extends DailyState {
  final Widget loadingWidget;
  DailyLoading({required this.loadingWidget});
}
