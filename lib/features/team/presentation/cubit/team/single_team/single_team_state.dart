part of 'single_team_cubit.dart';

sealed class SingleTeamState extends Equatable {
  const SingleTeamState();
}

final class SingleTeamInitial extends SingleTeamState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class SingleTeamLoading extends SingleTeamState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class SingleTeamLoaded extends SingleTeamState {
  final TeamEntity teamEntity;

  const SingleTeamLoaded({required this.teamEntity});
  @override
  // TODO: implement props
  List<Object?> get props => [teamEntity];
}

final class SingleTeamFailure extends SingleTeamState {
  final String failureTitle;

  const SingleTeamFailure({required this.failureTitle});
  @override
  // TODO: implement props
  List<Object?> get props => [failureTitle];
}
