import 'package:equatable/equatable.dart';
import 'package:vhack_client/shared/util/avatar_data.dart';

class MachineEntity extends Equatable {
  final String? machineID, machineName, machineDesc, machineOwnerID;
  final AvatarData? machineImage;
  final bool? machineStatus;
  final List<String>? machinePICsID;

  const MachineEntity(
      {this.machineID,
      this.machineName,
      this.machineDesc,
      this.machineOwnerID,
      this.machineImage,
      this.machineStatus,
      this.machinePICsID});
  @override
  List<Object?> get props => [
        machineID,
        machineName,
        machineDesc,
        machineOwnerID,
        machineImage,
        machineStatus,
        machinePICsID
      ];
}
