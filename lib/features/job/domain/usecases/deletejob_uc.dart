import 'package:vhack_client/features/job/domain/entity/job_entity.dart';
import 'package:vhack_client/features/job/domain/repositories/job_repo.dart';
import 'package:vhack_client/shared/constant/cutom_res.dart';

class DeleteJobUC {
  final JobRepo jobRepo;

  DeleteJobUC({required this.jobRepo});

  Future<ResponseData> call(String jobID) {
    return jobRepo.deleteJob(jobID);
  }
}
