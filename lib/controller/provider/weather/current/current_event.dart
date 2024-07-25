part of 'current_bloc.dart';

@immutable
sealed class CurrentEvent {}

class GenerateCurrentEvent extends CurrentEvent {
  final LocationData locationEntity;
  GenerateCurrentEvent({required this.locationEntity});
}
