import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:vhack_client/features/team/domain/entity/team_entity.dart';
import 'package:vhack_client/features/team/domain/usecases/team/deleteteam_uc.dart';
import 'package:vhack_client/features/team/domain/usecases/team/getteam_uc.dart';
import 'package:vhack_client/features/team/domain/usecases/team/postteam_uc.dart';
import 'package:vhack_client/features/team/domain/usecases/team/updateteam_uc.dart';
import 'package:vhack_client/features/team/presentation/screen/team_member_tabbar.dart';
import 'package:vhack_client/shared/constant/custom_snackbar.dart';

import '../../../../../shared/constant/cutom_res.dart';

part 'team_state.dart';

class TeamCubit extends Cubit<TeamState> {
  final PostTeamUC postTeamUC;
  final DeleteTeamUC deleteTeamUC;
  final GetTeamsUC getTeamsUC;
  final UpdateTeamUC updateTeamUC;
  TeamCubit(
      {required this.postTeamUC,
      required this.deleteTeamUC,
      required this.getTeamsUC,
      required this.updateTeamUC})
      : super(TeamInitial());

  Future<void> postTeam({required TeamEntity teamEntity}) async {
    try {
      final result = await postTeamUC.call(teamEntity);
      result.fold((l) => emit(TeamFailure(failureTitle: l)), (r) async {
        handleResponse(r);
        final teams = await getTeamsUC.call();
        teams.fold((l) => emit(TeamFailure(failureTitle: l.toString())), (r) {
          if (r.isEmpty) {
            emit(const TeamEmpty(emptyTitle: 'You dont have team yet'));
          } else {
            emit(TeamLoaded(teams: r));
          }
        });
      });
    } catch (e) {
      handleError(e);
    }
  }

  Future<void> deleteTeam({required String teamID}) async {
    try {
      final result = await deleteTeamUC.call(teamID);
      result.fold((l) => emit(TeamFailure(failureTitle: l)), (r) async {
        handleResponse(r);
        final teams = await getTeamsUC.call();
        teams.fold((l) => emit(TeamFailure(failureTitle: l.toString())), (r) {
          if (r.isEmpty) {
            emit(const TeamEmpty(emptyTitle: 'You dont have team yet'));
          } else {
            emit(TeamLoaded(teams: r));
          }
        });
      });
    } catch (e) {
      handleError(e);
    }
  }

  Future<void> updateTeam({required TeamEntity teamEntity}) async {
    try {
      final result = await updateTeamUC.call(teamEntity);
      result.fold(
          (l) => emit(TeamFailure(failureTitle: l)), (r) => handleResponse(r));
    } catch (e) {
      handleError(e);
    }
  }

  Future<void> getTeams() async {
    try {
      final result = await getTeamsUC.call();
      result.fold((l) => emit(TeamFailure(failureTitle: l)), (r) {
        if (r.isEmpty) {
          emit(const TeamEmpty(emptyTitle: 'You dont have team yet'));
        } else {
          emit(TeamLoaded(teams: r));
        }
      });
    } catch (e) {
      handleError(e);
    }
  }

  void handleResponse(ResponseData response) {
    String message = response.message;
    int status = response.status;

    debugPrint('Message: $message, Status: $status');

    if (status < 210) {
      debugPrint('Success: $message');
      SnackBarUtil.showSnackBar(message, Colors.green);
    } else {
      debugPrint('Failure: $message');
      SnackBarUtil.showSnackBar(message, Colors.red);
      emit(TeamFailure(failureTitle: message));
    }
  }

  void handleError(final response) {
    emit(TeamFailure(failureTitle: response.toString()));
    debugPrint('Team Cubit: ${response.toString()}');
    SnackBarUtil.showSnackBar(response.toString(), Colors.red);
  }
}
