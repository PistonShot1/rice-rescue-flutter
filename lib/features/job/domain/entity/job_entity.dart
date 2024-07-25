import 'package:equatable/equatable.dart';

import 'package:equatable/equatable.dart';
import 'package:vhack_client/features/auth/domain/entity/user_entity.dart';
import 'package:vhack_client/features/field/domain/entity/field_entity.dart';

class JobEntity extends Equatable {
  final String? jobID,
      jobName,
      jobType,
      jobDate,
      jobDesc,
      jobPriority,
      jobOwnerID,
      jobFieldID;
  final List<UserEntity>? jobMembers;
  final List<String>? jobMachinesID;
  final FieldEntity? jobField;

  const JobEntity(
      {this.jobID,
      this.jobName,
      this.jobType,
      this.jobDate,
      this.jobDesc,
      this.jobMembers,
      this.jobMachinesID,
      this.jobPriority,
      this.jobOwnerID,
      this.jobFieldID,
      this.jobField});

  @override
  List<Object?> get props => [
        jobID,
        jobName,
        jobType,
        jobDate,
        jobDesc,
        jobPriority,
        jobOwnerID,
        jobFieldID,
        jobMembers,
        jobMachinesID,
        jobField
      ];
}
