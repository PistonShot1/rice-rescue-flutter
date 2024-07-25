import 'package:vhack_client/features/job/data/database/job_remote_database.dart';
import 'package:vhack_client/features/job/data/model/job_model.dart';
import 'package:vhack_client/features/job/domain/entity/job_entity.dart';
import 'package:vhack_client/features/job/domain/repositories/job_repo.dart';
import 'package:vhack_client/shared/constant/cutom_res.dart';

class JobRepoImpl implements JobRepo {
  final JobRemoteDatabase jobRemoteDatabase;

  JobRepoImpl({required this.jobRemoteDatabase});
  @override
  Future<ResponseData> deleteJob(String jobID) async {
    return jobRemoteDatabase.deleteJob(jobID);
  }

  @override
  Future<List<JobEntity>> getJobs() async {
    final jobs = await jobRemoteDatabase.getJobs();
    return jobs.map((eachJob) => eachJob.toEntity()).toList();
  }

  @override
  Future<JobEntity?> getSingleJob(JobEntity jobEntity) async {
    final singleJob =
        await jobRemoteDatabase.getSingleJob(JobModel.fromEntity(jobEntity));
    return singleJob!.toEntity();
  }

  @override
  Future<ResponseData> postJob(JobEntity jobEntity) async {
    return await jobRemoteDatabase.postJob(JobModel.fromEntity(jobEntity));
  }
}
