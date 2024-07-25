import 'package:vhack_client/features/job/domain/entity/job_entity.dart';
import 'package:vhack_client/features/job/domain/repositories/job_repo.dart';
import 'package:vhack_client/shared/constant/cutom_res.dart';

class SingleJobUC {
  final JobRepo jobRepo;

  SingleJobUC({required this.jobRepo});

  Future<JobEntity?> call(JobEntity jobEntity) {
    return jobRepo.getSingleJob(jobEntity);
  }
}
