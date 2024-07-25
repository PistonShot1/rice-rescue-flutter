part of 'credential_cubit.dart';

sealed class CredentialState extends Equatable {
  const CredentialState();
}

final class CredentialInitial extends CredentialState {
  @override
  List<Object> get props => [];
}

final class CredentialLoading extends CredentialState {
  @override
  List<Object> get props => [];
}

final class CredentialSuccess extends CredentialState {
  @override
  List<Object> get props => [];
}

final class CredentialFailure extends CredentialState {
  final String failureTitle;
  const CredentialFailure({required this.failureTitle});
  @override
  List<Object> get props => [failureTitle];
}
