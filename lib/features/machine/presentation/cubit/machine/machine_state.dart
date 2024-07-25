part of 'machine_cubit.dart';

sealed class MachineState extends Equatable {
  const MachineState();
}

final class MachineInitial extends MachineState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class MachineLoading extends MachineState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class MachineLoaded extends MachineState {
  final List<MachineEntity> machines;

  const MachineLoaded({required this.machines});
  @override
  // TODO: implement props
  List<Object?> get props => [machines];
}

final class MachineEmpty extends MachineState {
  final String emptyTitle;
  const MachineEmpty({required this.emptyTitle});
  @override
  // TODO: implement props
  List<Object?> get props => [emptyTitle];
}

final class MachineFailure extends MachineState {
  final String failureTitle;
  const MachineFailure({required this.failureTitle});
  @override
  // TODO: implement props
  List<Object?> get props => [failureTitle];
}
