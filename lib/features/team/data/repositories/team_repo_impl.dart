import 'package:dartz/dartz.dart';
import 'package:vhack_client/features/team/data/database/team_remote_database.dart';
import 'package:vhack_client/features/team/data/model/team_model.dart';
import 'package:vhack_client/features/team/domain/entity/team_entity.dart';
import 'package:vhack_client/features/team/domain/repositories/team_repo.dart';
import 'package:vhack_client/shared/constant/cutom_res.dart';

class TeamRepoImpl implements TeamRepo {
  final TeamRemoteDatabase teamRemoteDatabase;

  TeamRepoImpl({required this.teamRemoteDatabase});
  @override
  Future<Either<String, ResponseData>> deleteTeam(String teamID) async {
    try {
      return Right(await teamRemoteDatabase.deleteTeam(teamID));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<TeamEntity>>> getTeams() async {
    try {
      final teams = await teamRemoteDatabase.getTeams();
      return Right(teams.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ResponseData>> postTeam(TeamEntity teamEntity) async {
    try {
      return Right(
          await teamRemoteDatabase.postTeam(TeamModel.fromEntity(teamEntity)));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, TeamEntity>> getSingleTeam(String userID) async {
    try {
      final team = await teamRemoteDatabase.getSingleTeam(userID);
      if (team == null) {
        return const Left('You have not created any team yet');
      }
      return Right(team.toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ResponseData>> updateTeam(TeamEntity teamEntity) async {
    try {
      return Right(await teamRemoteDatabase
          .updateTeam(TeamModel.fromEntity(teamEntity)));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
