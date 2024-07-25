import 'package:equatable/equatable.dart';
import 'package:vhack_client/shared/util/avatar_data.dart';

import '../../domain/entity/machine_entity.dart';

class MachineModel extends Equatable {
  final String? machineID;
  final String? machineName;
  final String? machineDesc;
  final String? machineOwnerID;
  final AvatarData? machineImage;
  final bool? machineStatus;
  final List<String>? machinePICsID;

  const MachineModel({
    this.machineID,
    this.machineName,
    this.machineDesc,
    this.machineOwnerID,
    this.machineImage,
    this.machineStatus,
    this.machinePICsID,
  });

  @override
  List<Object?> get props => [
        machineID,
        machineName,
        machineDesc,
        machineOwnerID,
        machineImage,
        machineStatus,
        machinePICsID,
      ];

  factory MachineModel.fromJson(Map<String, dynamic> json) {
    return MachineModel(
      machineID: json['machineID'],
      machineName: json['machineName'],
      machineDesc: json['machineDesc'],
      machineOwnerID: json['machineOwnerID'],
      machineImage: AvatarData.fromJson(json['machineImage']),
      machineStatus: json['machineStatus'],
      machinePICsID: List<String>.from(json['machinePICsID']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'machineID': machineID,
      'machineName': machineName,
      'machineDesc': machineDesc,
      'machineOwnerID': machineOwnerID,
      'machineImage': machineImage?.toJson(),
      'machineStatus': machineStatus,
      'machinePICsID': machinePICsID,
    };
  }

  factory MachineModel.fromEntity(MachineEntity entity) {
    return MachineModel(
      machineID: entity.machineID,
      machineName: entity.machineName,
      machineDesc: entity.machineDesc,
      machineOwnerID: entity.machineOwnerID,
      machineImage: entity.machineImage,
      machineStatus: entity.machineStatus,
      machinePICsID: entity.machinePICsID,
    );
  }

  MachineEntity toEntity() {
    return MachineEntity(
      machineID: machineID,
      machineName: machineName,
      machineDesc: machineDesc,
      machineOwnerID: machineOwnerID,
      machineImage: machineImage,
      machineStatus: machineStatus,
      machinePICsID: machinePICsID,
    );
  }
}
