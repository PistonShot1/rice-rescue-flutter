import 'package:dartz/dartz.dart';
import 'package:vhack_client/features/team/domain/entity/team_entity.dart';
import 'package:vhack_client/shared/constant/cutom_res.dart';

abstract class TeamRepo {
  Future<Either<String, ResponseData>> postTeam(TeamEntity teamEntity);
  Future<Either<String, ResponseData>> deleteTeam(String teamID);
  Future<Either<String, List<TeamEntity>>> getTeams();
  Future<Either<String, TeamEntity>> getSingleTeam(String userID);
  Future<Either<String, ResponseData>> updateTeam(TeamEntity teamEntity);
}
