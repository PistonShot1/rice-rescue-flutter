import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:vhack_client/features/field/presentation/cubit/single_field/single_field_cubit.dart';
import 'package:vhack_client/features/team/domain/entity/team_entity.dart';
import 'package:vhack_client/features/team/domain/usecases/team/getsingleteam_uc.dart';
import 'package:vhack_client/features/team/presentation/cubit/team/team_cubit.dart';

import '../../../../../../shared/constant/custom_snackbar.dart';
import '../../../../../../shared/constant/cutom_res.dart';

part 'single_team_state.dart';

class SingleTeamCubit extends Cubit<SingleTeamState> {
  final GetSingleTeamUC getSingleTeamUC;
  SingleTeamCubit({required this.getSingleTeamUC}) : super(SingleTeamInitial());

  Future<void> getSingleJob({required String userID}) async {
    try {
      final result = await getSingleTeamUC.call(userID);

      result.fold((l) => emit(SingleTeamFailure(failureTitle: l)),
          (r) => emit(SingleTeamLoaded(teamEntity: r)));
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
      emit(SingleTeamFailure(failureTitle: message));
    }
  }

  void handleError(final response) {
    emit(SingleTeamFailure(failureTitle: response.toString()));
    debugPrint('Single Team Cubit: ${response.toString()}');
    SnackBarUtil.showSnackBar(response.toString(), Colors.red);
  }
}
