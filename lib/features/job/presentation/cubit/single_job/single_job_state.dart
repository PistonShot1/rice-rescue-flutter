part of 'single_job_cubit.dart';

sealed class SingleJobState extends Equatable {
  const SingleJobState();
}

final class SingleJobInitial extends SingleJobState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class SingleJobLoaded extends SingleJobState {
  final JobEntity jobEntity;

  const SingleJobLoaded({required this.jobEntity});
  @override
  // TODO: implement props
  List<Object?> get props => [jobEntity];
}

final class SingleJobLoading extends SingleJobState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class SingleJobFailure extends SingleJobState {
  final String failureTitle;

  const SingleJobFailure({required this.failureTitle});
  @override
  // TODO: implement props
  List<Object?> get props => [failureTitle];
}

final class SingleJobEmpty extends SingleJobState {
  final String emptyTitle;

  const SingleJobEmpty({required this.emptyTitle});
  @override
  // TODO: implement props
  List<Object?> get props => [emptyTitle];
}
