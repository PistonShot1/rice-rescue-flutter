import 'package:equatable/equatable.dart';
import 'package:vhack_client/features/auth/data/model/user_model.dart';
import 'package:vhack_client/features/team/domain/entity/team_entity.dart';

import '../../../auth/domain/entity/user_entity.dart';

class TeamModel extends Equatable {
  final String? teamID, teamByID, teamName;
  final UserModel? teamBy;
  final List<UserModel>? teamMember;
  final DateTime? teamCreatedAt, teamUpdatedAt;

  const TeamModel(
      {this.teamID,
      this.teamByID,
      this.teamName,
      this.teamBy,
      this.teamMember,
      this.teamCreatedAt,
      this.teamUpdatedAt});

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    List<UserModel> teamMember = [];
    if (json['teamMember'] != null) {
      teamMember = (json['teamMember'] as List)
          .map((memberJson) => UserModel.fromJson(memberJson))
          .toList();
    }
    return TeamModel(
      teamID: json['teamID'],
      teamByID: json['teamByID'],
      teamName: json['teamName'],
      teamBy: UserModel.fromJson(json['teamBy']),
      teamMember: teamMember,
      teamCreatedAt: json['teamCreatedAt'] != null
          ? DateTime.parse(json['teamCreatedAt'])
          : null,
      teamUpdatedAt: json['teamUpdatedAt'] != null
          ? DateTime.parse(json['teamUpdatedAt'])
          : null,
    );
  }

  factory TeamModel.fromEntity(TeamEntity teamEntity) {
    List<UserModel>? teamMembers;
    if (teamEntity.teamMember != null) {
      teamMembers = teamEntity.teamMember!
          .map((memberEntity) => UserModel.fromEntity(memberEntity))
          .toList();
    }

    return TeamModel(
        teamID: teamEntity.teamID,
        teamByID: teamEntity.teamByID,
        teamName: teamEntity.teamName,
        teamBy: teamEntity.teamBy != null
            ? UserModel.fromEntity(teamEntity.teamBy!)
            : null,
        teamMember: teamMembers,
        teamCreatedAt: teamEntity.teamCreatedAt,
        teamUpdatedAt: teamEntity.teamUpdatedAt);
  }

  TeamEntity toEntity() {
    List<UserEntity>? teamMembers;
    if (teamMember != null) {
      teamMembers =
          teamMember!.map((memberModel) => memberModel.toEntity()).toList();
    }

    return TeamEntity(
        teamID: teamID,
        teamByID: teamByID,
        teamName: teamName,
        teamBy: teamBy != null ? teamBy!.toEntity() : null,
        teamMember: teamMembers,
        teamCreatedAt: teamCreatedAt,
        teamUpdatedAt: teamUpdatedAt);
  }

  @override
  List<Object?> get props => [
        teamID,
        teamByID,
        teamName,
        teamBy,
        teamMember,
        teamCreatedAt,
        teamUpdatedAt
      ];
}
