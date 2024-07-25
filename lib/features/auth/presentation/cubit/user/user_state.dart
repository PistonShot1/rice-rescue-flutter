part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();
}

final class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

final class UserLoaded extends UserState {
  final List<UserEntity> users;
  const UserLoaded({required this.users});
  @override
  List<Object> get props => [users];
}

final class UserEmpty extends UserState {
  final String emptyTitle;
  const UserEmpty({required this.emptyTitle});
  @override
  List<Object> get props => [emptyTitle];
}

final class UserFailure extends UserState {
  final String failureTitle;
  const UserFailure({required this.failureTitle});
  @override
  List<Object> get props => [failureTitle];
}
