part of 'field_cubit.dart';

sealed class FieldState extends Equatable {
  const FieldState();
}

final class FieldInitial extends FieldState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

final class FieldLoaded extends FieldState {
  final List<FieldEntity> fields;

  const FieldLoaded({required this.fields});

  @override
  List<Object?> get props => [fields];
}

final class FieldFailure extends FieldState {
  final String failureTitle;

  const FieldFailure({required this.failureTitle});
  @override
  // TODO: implement props
  List<Object?> get props => [failureTitle];
}
