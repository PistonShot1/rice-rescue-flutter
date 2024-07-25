import 'package:equatable/equatable.dart';
import 'package:vhack_client/shared/util/avatar_data.dart';
import '../../domain/entity/crop_entity.dart';

class CropModel extends Equatable {
  final String? cropID,
      cropCA,
      cropDisease,
      cropNutrient,
      cropPrecaution,
      cropOwnerID;
  final AvatarData? cropImage;
  final DateTime? cropDate;

  const CropModel({
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

  factory CropModel.fromJson(Map<String, dynamic> json) {
    return CropModel(
      cropID: json['cropID'],
      cropCA: json['cropCA'],
      cropDisease: json['cropDisease'],
      cropNutrient: json['cropNutrient'],
      cropPrecaution: json['cropPrecaution'],
      cropOwnerID: json['cropOwnerID'],
      cropImage: AvatarData.fromJson(json['cropImage']),
      cropDate:
          json['cropDate'] != null ? DateTime.parse(json['cropDate']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cropID': cropID,
      'cropCA': cropCA,
      'cropDisease': cropDisease,
      'cropNutrient': cropNutrient,
      'cropPrecaution': cropPrecaution,
      'cropOwnerID': cropOwnerID,
      'cropImage': cropImage?.toJson(),
      'cropDate': cropDate?.toIso8601String(),
    };
  }

  factory CropModel.fromEntity(CropEntity entity) {
    return CropModel(
      cropID: entity.cropID,
      cropCA: entity.cropCA,
      cropDisease: entity.cropDisease,
      cropNutrient: entity.cropNutrient,
      cropPrecaution: entity.cropPrecaution,
      cropOwnerID: entity.cropOwnerID,
      cropImage: entity.cropImage,
      cropDate: entity.cropDate,
    );
  }

  CropEntity toEntity() {
    return CropEntity(
      cropID: cropID,
      cropCA: cropCA,
      cropDisease: cropDisease,
      cropNutrient: cropNutrient,
      cropPrecaution: cropPrecaution,
      cropOwnerID: cropOwnerID,
      cropImage: cropImage,
      cropDate: cropDate,
    );
  }
}
