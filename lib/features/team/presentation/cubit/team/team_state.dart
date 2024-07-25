part of 'team_cubit.dart';

sealed class TeamState extends Equatable {
  const TeamState();
}

final class TeamInitial extends TeamState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class TeamLoaded extends TeamState {
  final List<TeamEntity> teams;

  const TeamLoaded({required this.teams});
  @override
  // TODO: implement props
  List<Object?> get props => [teams];
}

final class TeamFailure extends TeamState {
  final String failureTitle;

  const TeamFailure({required this.failureTitle});
  @override
  // TODO: implement props
  List<Object?> get props => [failureTitle];
}

final class TeamEmpty extends TeamState {
  final String emptyTitle;

  const TeamEmpty({required this.emptyTitle});
  @override
  // TODO: implement props
  List<Object?> get props => [emptyTitle];
}

final class TeamLoading extends TeamState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
