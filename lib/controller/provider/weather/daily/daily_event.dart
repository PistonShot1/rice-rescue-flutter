part of 'daily_bloc.dart';

@immutable
sealed class DailyEvent {}

class GenerateDailyEvent extends DailyEvent {
  final LocationData locationEntity;
  GenerateDailyEvent({required this.locationEntity});
}
