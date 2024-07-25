import 'package:equatable/equatable.dart';
import 'package:vhack_client/features/auth/domain/entity/user_entity.dart';

class TeamEntity extends Equatable {
  final String? teamID, teamByID, teamName;
  final UserEntity? teamBy;
  final List<UserEntity>? teamMember;
  final DateTime? teamCreatedAt, teamUpdatedAt;

  const TeamEntity(
      {this.teamID,
      this.teamByID,
      this.teamName,
      this.teamBy,
      this.teamMember,
      this.teamCreatedAt,
      this.teamUpdatedAt});

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
