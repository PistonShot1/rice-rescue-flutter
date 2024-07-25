part of 'crop_cubit.dart';

sealed class CropState extends Equatable {
  const CropState();
}

final class CropInitial extends CropState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class CropLoading extends CropState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class CropEmpty extends CropState {
  final String emptyTitle;

  const CropEmpty({required this.emptyTitle});
  @override
  // TODO: implement props
  List<Object?> get props => [emptyTitle];
}

final class CropLoaded extends CropState {
  final List<CropEntity> crops;

  const CropLoaded({required this.crops});
  @override
  // TODO: implement props
  List<Object?> get props => [crops];
}

final class CropFailure extends CropState {
  final String failureTitle;

  const CropFailure({required this.failureTitle});
  @override
  // TODO: implement props
  List<Object?> get props => [failureTitle];
}
