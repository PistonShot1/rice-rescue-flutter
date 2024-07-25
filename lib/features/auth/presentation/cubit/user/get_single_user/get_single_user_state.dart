part of 'get_single_user_cubit.dart';

sealed class GetSingleUserState extends Equatable {
  const GetSingleUserState();
}

final class GetSingleUserInitial extends GetSingleUserState {
  @override
  List<Object> get props => [];
}

final class GetSingleUserLoaded extends GetSingleUserState {
  final UserEntity userEntity;

  const GetSingleUserLoaded({required this.userEntity});
  @override
  List<Object> get props => [userEntity];
}

final class GetSingleUserFailure extends GetSingleUserState {
  final String failureTitle;
  const GetSingleUserFailure({required this.failureTitle});
  @override
  List<Object> get props => [failureTitle];
}
