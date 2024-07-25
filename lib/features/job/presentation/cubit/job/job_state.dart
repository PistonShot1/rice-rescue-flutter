part of 'job_cubit.dart';

sealed class JobState extends Equatable {
  const JobState();
}

final class JobInitial extends JobState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class JobLoaded extends JobState {
  final List<JobEntity> jobs;

  const JobLoaded({required this.jobs});
  @override
  // TODO: implement props
  List<Object?> get props => [jobs];
}

final class JobEmpty extends JobState {
  final String emptyTitle;
  const JobEmpty({required this.emptyTitle});
  @override
  // TODO: implement props
  List<Object?> get props => [emptyTitle];
}

final class JobFailure extends JobState {
  final String failureTitle;
  const JobFailure({required this.failureTitle});
  @override
  // TODO: implement props
  List<Object?> get props => [failureTitle];
}
