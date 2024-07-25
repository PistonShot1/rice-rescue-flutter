import 'package:equatable/equatable.dart';
import 'package:vhack_client/features/field/domain/entity/field_entity.dart';

class FieldModel extends Equatable {
  final FieldST? fieldST;
  final FieldSM? fieldSM;
  final List<Location>? fieldLocation;
  final String? fieldID;
  final String? fieldName;
  final String? fieldCA;
  final String? fieldPCT;
  final String? fieldSeedDate;
  final String? fieldOwnerID;

  const FieldModel({
    this.fieldST,
    this.fieldSM,
    this.fieldLocation,
    this.fieldID,
    this.fieldName,
    this.fieldCA,
    this.fieldPCT,
    this.fieldSeedDate,
    this.fieldOwnerID,
  });

  @override
  List<Object?> get props => [
        fieldST,
        fieldSM,
        fieldLocation,
        fieldID,
        fieldName,
        fieldCA,
        fieldPCT,
        fieldSeedDate,
        fieldOwnerID,
      ];

  factory FieldModel.fromJson(Map<String, dynamic> json) {
    return FieldModel(
      fieldST: FieldST.fromJson(json['fieldST']),
      fieldSM: FieldSM.fromJson(json['fieldSM']),
      fieldLocation: (json['fieldLocation'] as List<dynamic>)
          .map((location) => Location.fromJson(location))
          .toList(),
      fieldID: json['fieldID'],
      fieldName: json['fieldName'],
      fieldCA: json['fieldCA'],
      fieldPCT: json['fieldPCT'],
      fieldSeedDate: json['fieldSeedDate'],
      fieldOwnerID: json['fieldOwnerID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fieldST': fieldST!.toJson(),
      'fieldSM': fieldSM!.toJson(),
      'fieldLocation':
          fieldLocation!.map((location) => location.toJson()).toList(),
      'fieldID': fieldID,
      'fieldName': fieldName,
      'fieldCA': fieldCA,
      'fieldSeedDate': fieldSeedDate!,
      'fieldOwnerID': fieldOwnerID,
    };
  }

  FieldEntity toEntity() {
    return FieldEntity(
      fieldID: fieldID,
      fieldName: fieldName,
      fieldCA: fieldCA,
      fieldSeedDate: fieldSeedDate,
      fieldOwnerID: fieldOwnerID,
      fieldSTEntity: fieldST!.toEntity(),
      fieldSMEntity: fieldSM!.toEntity(),
      locationEntity:
          fieldLocation!.map((location) => location.toEntity()).toList(),
    );
  }

  factory FieldModel.fromEntity(FieldEntity fieldEntity) => FieldModel(
        fieldID: fieldEntity.fieldID,
        fieldName: fieldEntity.fieldName,
        fieldCA: fieldEntity.fieldCA,
        fieldSeedDate: fieldEntity.fieldSeedDate,
        fieldOwnerID: fieldEntity.fieldOwnerID,
        fieldST: FieldST.fromEntity(fieldEntity.fieldSTEntity!),
        fieldSM: FieldSM.fromEntity(fieldEntity.fieldSMEntity!),
        fieldLocation: fieldEntity.locationEntity!
            .map((location) => Location.fromEntity(location))
            .toList(),
      );
}

class FieldST extends Equatable {
  final List<double> stPrev;
  final List<double> stTime;
  final double stCurrent;
  final List<Location> stLocation;

  const FieldST({
    required this.stPrev,
    required this.stTime,
    required this.stCurrent,
    required this.stLocation,
  });

  @override
  List<Object?> get props => [stPrev, stTime, stCurrent, stLocation];

  factory FieldST.fromJson(Map<String, dynamic> json) {
    return FieldST(
      stPrev: (json['stPrev'] as List<dynamic>).cast<double>(),
      stTime: (json['stTime'] as List<dynamic>).cast<double>(),
      stCurrent: json['stCurrent'],
      stLocation: (json['stLocation'] as List<dynamic>)
          .map((location) => Location.fromJson(location))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stPrev': stPrev,
      'stTime': stTime,
      'stCurrent': stCurrent,
      'stLocation': stLocation.map((location) => location.toJson()).toList(),
    };
  }

  FieldSTEntity toEntity() {
    return FieldSTEntity(
      stPrev: stPrev,
      stTime: stTime,
      stCurrent: stCurrent,
      stLocation: stLocation.map((location) => location.toEntity()).toList(),
    );
  }

  factory FieldST.fromEntity(FieldSTEntity fieldSTEntity) => FieldST(
        stPrev: fieldSTEntity.stPrev,
        stTime: fieldSTEntity.stTime,
        stCurrent: fieldSTEntity.stCurrent,
        stLocation: fieldSTEntity.stLocation
            .map((location) => Location.fromEntity(location))
            .toList(),
      );
}

class FieldSM extends Equatable {
  final List<double> smPrev;
  final List<double> smTime;
  final double smCurrent;
  final List<Location> smLocation;

  const FieldSM({
    required this.smPrev,
    required this.smTime,
    required this.smCurrent,
    required this.smLocation,
  });

  @override
  List<Object?> get props => [smPrev, smTime, smCurrent, smLocation];

  factory FieldSM.fromJson(Map<String, dynamic> json) {
    return FieldSM(
      smPrev: (json['smPrev'] as List<dynamic>).cast<double>(),
      smTime: (json['smTime'] as List<dynamic>).cast<double>(),
      smCurrent: json['smCurrent'],
      smLocation: (json['smLocation'] as List<dynamic>)
          .map((location) => Location.fromJson(location))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'smPrev': smPrev,
      'smTime': smTime,
      'smCurrent': smCurrent,
      'smLocation': smLocation.map((location) => location.toJson()).toList(),
    };
  }

  FieldSMEntity toEntity() {
    return FieldSMEntity(
      smPrev: smPrev,
      smTime: smTime,
      smCurrent: smCurrent,
      smLocation: smLocation.map((location) => location.toEntity()).toList(),
    );
  }

  factory FieldSM.fromEntity(FieldSMEntity fieldSMEntity) => FieldSM(
        smPrev: fieldSMEntity.smPrev,
        smTime: fieldSMEntity.smTime,
        smCurrent: fieldSMEntity.smCurrent,
        smLocation: fieldSMEntity.smLocation
            .map((location) => Location.fromEntity(location))
            .toList(),
      );
}

class Location extends Equatable {
  final double lat;
  final double long;

  const Location({
    required this.lat,
    required this.long,
  });

  @override
  List<Object?> get props => [lat, long];

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json['lat'],
      long: json['long'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'long': long,
    };
  }

  LocationEntity toEntity() {
    return LocationEntity(lat: lat, long: long);
  }

  factory Location.fromEntity(LocationEntity locationEntity) => Location(
        lat: locationEntity.lat,
        long: locationEntity.long,
      );
}
