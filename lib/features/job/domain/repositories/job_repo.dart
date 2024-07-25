import 'package:vhack_client/features/job/domain/entity/job_entity.dart';
import 'package:vhack_client/shared/constant/cutom_res.dart';

abstract class JobRepo {
  Future<ResponseData> postJob(JobEntity jobEntity);
  Future<ResponseData> deleteJob(String jobID);
  Future<List<JobEntity>> getJobs();
  Future<JobEntity?> getSingleJob(JobEntity jobEntity);
}
