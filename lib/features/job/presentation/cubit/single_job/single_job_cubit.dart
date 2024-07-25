import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:vhack_client/features/auth/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:vhack_client/features/job/domain/entity/job_entity.dart';
import 'package:vhack_client/features/job/domain/usecases/singlejob_uc.dart';

import '../../../../../shared/constant/custom_snackbar.dart';
import '../../../../../shared/constant/cutom_res.dart';

part 'single_job_state.dart';

class SingleJobCubit extends Cubit<SingleJobState> {
  final SingleJobUC singleJobUC;

  SingleJobCubit({required this.singleJobUC}) : super(SingleJobInitial());

  Future<void> getSingleJob({required JobEntity jobEntity}) async {
    try {
      final result = await singleJobUC.call(jobEntity);
      if (result == null) {
        emit(const SingleJobFailure(failureTitle: 'Something was error'));
      } else {
        emit(SingleJobLoaded(jobEntity: result));
      }
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
      emit(SingleJobFailure(failureTitle: message));
    }
  }

  void handleError(final response) {
    emit(SingleJobFailure(failureTitle: response.toString()));
    debugPrint('Single Job Cubit: ${response.toString()}');
    SnackBarUtil.showSnackBar(response.toString(), Colors.red);
  }
}
