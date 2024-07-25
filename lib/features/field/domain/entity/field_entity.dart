import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vhack_client/features/field/data/model/field_model.dart';

class FieldEntity extends Equatable {
  final String? fieldID;
  final String? fieldName;
  final String? fieldCA;
  final String? fieldPCT;
  final String? fieldSeedDate;
  final String? fieldOwnerID;
  final FieldSMEntity? fieldSMEntity;
  final FieldSTEntity? fieldSTEntity;
  final List<LocationEntity>? locationEntity;

  const FieldEntity(
      {this.fieldName,
      this.fieldCA,
      this.fieldPCT,
      this.fieldSeedDate,
      this.fieldOwnerID,
      this.fieldID,
      this.fieldSTEntity,
      this.fieldSMEntity,
      this.locationEntity});

  @override
  List<Object?> get props => [
        fieldID,
        fieldName,
        fieldCA,
        fieldPCT,
        fieldSeedDate,
        fieldOwnerID,
        fieldSTEntity,
        fieldSMEntity,
        locationEntity
      ];
}

class FieldSTEntity extends Equatable {
  final List<double> stPrev;
  final List<double> stTime;
  final double stCurrent;
  final List<LocationEntity> stLocation;

  const FieldSTEntity(
      {required this.stPrev,
      required this.stTime,
      required this.stCurrent,
      required this.stLocation});

  @override
  List<Object?> get props => [stPrev, stTime, stCurrent, stLocation];
}

class FieldSMEntity extends Equatable {
  final List<double> smPrev;
  final List<double> smTime;
  final double smCurrent;
  final List<LocationEntity> smLocation;

  const FieldSMEntity({
    required this.smPrev,
    required this.smTime,
    required this.smCurrent,
    required this.smLocation,
  });

  @override
  List<Object?> get props => [smPrev, smTime, smCurrent, smLocation];
}

class LocationEntity extends Equatable {
  final double lat, long;

  const LocationEntity({required this.lat, required this.long});

  @override
  List<Object?> get props => [lat, long];
}
