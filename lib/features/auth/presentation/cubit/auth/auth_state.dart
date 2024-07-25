part of 'auth_cubit.dart';

@immutable
sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

final class Authenticated extends AuthState {
  final String userID;

  const Authenticated({required this.userID});
  @override
  List<Object?> get props => [userID];
}

final class UnAuthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthenticatedFailed extends AuthState {
  final String failureTitle;
  const AuthenticatedFailed({required this.failureTitle});

  @override
  List<Object?> get props => [failureTitle];
}
