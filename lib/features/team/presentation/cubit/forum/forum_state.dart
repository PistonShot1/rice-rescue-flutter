part of 'forum_cubit.dart';

sealed class ForumState extends Equatable {
  const ForumState();
}

final class ForumInitial extends ForumState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class ForumLoaded extends ForumState {
  final List<ForumEntity> forums;

  const ForumLoaded({required this.forums});
  @override
  // TODO: implement props
  List<Object?> get props => [forums];
}

final class ForumLoading extends ForumState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class ForumEmpty extends ForumState {
  final String emptyTitle;
  const ForumEmpty({required this.emptyTitle});
  @override
  // TODO: implement props
  List<Object?> get props => [emptyTitle];
}

final class ForumFailure extends ForumState {
  final String failureTitle;
  const ForumFailure({required this.failureTitle});
  @override
  // TODO: implement props
  List<Object?> get props => [failureTitle];
}
