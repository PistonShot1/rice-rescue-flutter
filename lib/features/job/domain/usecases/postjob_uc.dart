import 'package:vhack_client/features/job/domain/entity/job_entity.dart';
import 'package:vhack_client/features/job/domain/repositories/job_repo.dart';
import 'package:vhack_client/shared/constant/cutom_res.dart';

class PostJobUC {
  final JobRepo jobRepo;

  PostJobUC({required this.jobRepo});

  Future<ResponseData> call(JobEntity jobEntity) {
    return jobRepo.postJob(jobEntity);
  }
}
