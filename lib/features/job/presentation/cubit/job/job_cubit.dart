import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:vhack_client/features/field/domain/usecase/postfield_uc.dart';
import 'package:vhack_client/features/job/domain/entity/job_entity.dart';
import 'package:vhack_client/features/job/domain/usecases/deletejob_uc.dart';
import 'package:vhack_client/features/job/domain/usecases/getjobs_uc.dart';
import 'package:vhack_client/features/job/domain/usecases/postjob_uc.dart';

import '../../../../../shared/constant/custom_snackbar.dart';
import '../../../../../shared/constant/cutom_res.dart';

part 'job_state.dart';

class JobCubit extends Cubit<JobState> {
  final PostJobUC postJobUC;
  final DeleteJobUC deleteJobUC;
  final GetJobsUC getJobsUC;

  JobCubit(
      {required this.postJobUC,
      required this.deleteJobUC,
      required this.getJobsUC})
      : super(JobInitial());

  Future<void> postJob({required JobEntity jobEntity}) async {
    try {
      final result = await postJobUC.call(jobEntity);
      handleResponse(result);
    } catch (e) {
      handleError(e);
    }
  }

  Future<void> deleteJob({required String jobID}) async {
    try {
      final result = await deleteJobUC.call(jobID);
      final jobs = await getJobsUC.call();
      emit(JobLoaded(jobs: jobs));
      handleResponse(result);
    } catch (e) {
      handleError(e);
    }
  }

  Future<void> getJobs() async {
    try {
      final result = await getJobsUC.call();
      if (result.isEmpty) {
        emit(const JobEmpty(emptyTitle: 'Oops nothing to show here'));
      } else {
        emit(JobLoaded(jobs: result));
      }
      for (var eachJob in result) {
        print(eachJob.jobMembers);
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
      emit(JobFailure(failureTitle: message));
    }
  }

  void handleError(final response) {
    emit(JobFailure(failureTitle: response.toString()));
    debugPrint('Job Cubit: ${response.toString()}');
    SnackBarUtil.showSnackBar(response.toString(), Colors.red);
  }
}
