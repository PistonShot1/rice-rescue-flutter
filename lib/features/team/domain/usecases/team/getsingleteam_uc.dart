import 'package:dartz/dartz.dart';
import 'package:vhack_client/features/team/data/model/team_model.dart';
import 'package:vhack_client/features/team/domain/entity/forum_entity.dart';
import 'package:vhack_client/features/team/domain/entity/team_entity.dart';
import 'package:vhack_client/features/team/domain/repositories/forum_repo.dart';
import 'package:vhack_client/features/team/domain/repositories/team_repo.dart';
import 'package:vhack_client/shared/constant/cutom_res.dart';

class GetSingleTeamUC {
  final TeamRepo teamRepo;

  GetSingleTeamUC({required this.teamRepo});

  Future<Either<String, TeamEntity>> call(String userID) {
    return teamRepo.getSingleTeam(userID);
  }
}
