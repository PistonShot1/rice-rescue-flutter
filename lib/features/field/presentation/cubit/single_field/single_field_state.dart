part of 'single_field_cubit.dart';

sealed class SingleFieldState extends Equatable {}

final class SingleFieldInitial extends SingleFieldState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

final class SingleFieldLoaded extends SingleFieldState {
  final FieldEntity fieldEntity;
  SingleFieldLoaded({required this.fieldEntity});
  @override
  // TODO: implement props
  List<Object?> get props => [fieldEntity];
}

final class SingleFieldEmpty extends SingleFieldState {
  final String emptyTitle;
  SingleFieldEmpty({required this.emptyTitle});
  @override
  // TODO: implement props
  List<Object?> get props => [emptyTitle];
}

final class SingleFieldFailure extends SingleFieldState {
  final String failureTitle;

  SingleFieldFailure({required this.failureTitle});
  @override
  // TODO: implement props
  List<Object?> get props => [failureTitle];
}
