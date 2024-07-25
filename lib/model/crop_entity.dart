import 'package:equatable/equatable.dart';

class CropEntity extends Equatable {
  final String? cropID;
  final String? cropLocalID;
  final String? cropDisease;
  final String? cropAt;
  final String? cropURL;
  final String? cropFileName;
  final String? cropPrecaution;
  final String? cropNutrient;
  final String? cropHealth;

  CropEntity({
    this.cropID,
    this.cropLocalID,
    this.cropDisease,
    this.cropAt,
    this.cropURL,
    this.cropFileName,
    this.cropPrecaution,
    this.cropNutrient,
    this.cropHealth,
  });

  @override
  List<Object?> get props => [
        cropID,
        cropLocalID,
        cropDisease,
        cropAt,
        cropURL,
        cropFileName,
        cropPrecaution,
        cropNutrient,
        cropHealth,
      ];
}
