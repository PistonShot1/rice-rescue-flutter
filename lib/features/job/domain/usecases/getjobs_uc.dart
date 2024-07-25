import 'package:vhack_client/features/job/domain/entity/job_entity.dart';
import 'package:vhack_client/features/job/domain/repositories/job_repo.dart';
import 'package:vhack_client/shared/constant/cutom_res.dart';

class GetJobsUC {
  final JobRepo jobRepo;

  GetJobsUC({required this.jobRepo});

  Future<List<JobEntity>> call() {
    return jobRepo.getJobs();
  }
}
