import 'package:dartz/dartz.dart';
import 'package:vhack_client/features/team/domain/entity/forum_entity.dart';
import 'package:vhack_client/features/team/domain/entity/team_entity.dart';
import 'package:vhack_client/features/team/domain/repositories/forum_repo.dart';
import 'package:vhack_client/features/team/domain/repositories/team_repo.dart';
import 'package:vhack_client/shared/constant/cutom_res.dart';

class PostTeamUC {
  final TeamRepo teamRepo;

  PostTeamUC({required this.teamRepo});

  Future<Either<String, ResponseData>> call(TeamEntity teamEntity) {
    return teamRepo.postTeam(teamEntity);
  }
}
