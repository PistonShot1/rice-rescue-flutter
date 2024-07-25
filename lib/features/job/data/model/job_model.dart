import 'package:equatable/equatable.dart';
import 'package:vhack_client/features/auth/data/model/user_model.dart';
import 'package:vhack_client/features/field/data/model/field_model.dart';
import 'package:vhack_client/features/field/domain/entity/field_entity.dart';

import '../../../auth/domain/entity/user_entity.dart';
import '../../domain/entity/job_entity.dart';

class JobModel extends Equatable {
  final String? jobID,
      jobName,
      jobType,
      jobDate,
      jobDesc,
      jobPriority,
      jobOwnerID,
      jobFieldID;
  final List<UserModel>? jobMembers;
  final List<String>? jobMachinesID;
  final FieldModel? jobField;

  const JobModel(
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

  factory JobModel.fromJson(Map<String, dynamic> json) {
    List<UserModel> listMember = [];
    if (json['jobMembers'] != null) {
      listMember = (json['jobMembers'] as List)
          .map((memberJson) => UserModel.fromJson(memberJson))
          .toList();
    }
    return JobModel(
        jobID: json['jobID'],
        jobName: json['jobName'],
        jobType: json['jobType'],
        jobDate: json['jobDate'],
        jobDesc: json['jobDesc'],
        jobPriority: json['jobPriority'],
        jobOwnerID: json['jobOwnerID'],
        jobFieldID: json['jobFieldID'],
        jobMembers: listMember,
        jobMachinesID: (json['jobMachinesID'] as List<dynamic>).cast<String>(),
        jobField: FieldModel.fromJson(json['jobField']));
  }

  factory JobModel.fromEntity(JobEntity jobEntity) {
    List<UserModel>? listJobs;
    if (jobEntity.jobMembers != null) {
      listJobs = jobEntity.jobMembers!
          .map((memberEntity) => UserModel.fromEntity(memberEntity))
          .toList();
    }
    return JobModel(
        jobID: jobEntity.jobID,
        jobName: jobEntity.jobName,
        jobType: jobEntity.jobType,
        jobDate: jobEntity.jobDate,
        jobDesc: jobEntity.jobDesc,
        jobPriority: jobEntity.jobPriority,
        jobOwnerID: jobEntity.jobOwnerID,
        jobFieldID: jobEntity.jobFieldID,
        jobMembers: listJobs,
        jobMachinesID: jobEntity.jobMachinesID,
        jobField: jobEntity.jobField != null
            ? FieldModel.fromEntity(jobEntity.jobField!)
            : null);
  }

  JobEntity toEntity() {
    List<UserEntity>? listMember;
    if (jobMembers != null) {
      listMember =
          jobMembers!.map((memberModel) => memberModel.toEntity()).toList();
    }
    return JobEntity(
        jobID: jobID,
        jobName: jobName,
        jobType: jobType,
        jobDate: jobDate,
        jobDesc: jobDesc,
        jobPriority: jobPriority,
        jobOwnerID: jobOwnerID,
        jobFieldID: jobFieldID,
        jobMembers: listMember,
        jobMachinesID: jobMachinesID,
        jobField: jobField?.toEntity());
  }
}
