part of 'hourly_bloc.dart';

@immutable
sealed class HourlyEvent {}

class GenerateHourlyEvent extends HourlyEvent {
  final LocationData locationEntity;
  GenerateHourlyEvent({required this.locationEntity});
}
