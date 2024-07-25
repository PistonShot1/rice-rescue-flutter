import 'package:equatable/equatable.dart';
import 'package:vhack_client/shared/util/avatar_data.dart';

class CropEntity extends Equatable {
  final String? cropID,
      cropCA,
      cropDisease,
      cropNutrient,
      cropPrecaution,
      cropOwnerID;
  final AvatarData? cropImage;
  final DateTime? cropDate;

  const CropEntity({
    this.cropID,
    this.cropCA,
    this.cropDisease,
    this.cropNutrient,
    this.cropPrecaution,
    this.cropOwnerID,
    this.cropImage,
    this.cropDate,
  });

  @override
  List<Object?> get props => [
        cropID,
        cropCA,
        cropDisease,
        cropNutrient,
        cropPrecaution,
        cropOwnerID,
        cropImage,
        cropDate,
      ];
}
