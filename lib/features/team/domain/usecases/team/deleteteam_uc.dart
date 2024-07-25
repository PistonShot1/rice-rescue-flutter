import 'package:dartz/dartz.dart';
import 'package:vhack_client/features/team/domain/entity/forum_entity.dart';
import 'package:vhack_client/features/team/domain/entity/team_entity.dart';
import 'package:vhack_client/features/team/domain/repositories/forum_repo.dart';
import 'package:vhack_client/features/team/domain/repositories/team_repo.dart';
import 'package:vhack_client/shared/constant/cutom_res.dart';

class DeleteTeamUC {
  final TeamRepo teamRepo;

  DeleteTeamUC({required this.teamRepo});

  Future<Either<String, ResponseData>> call(String teamID) {
    return teamRepo.deleteTeam(teamID);
  }
}
