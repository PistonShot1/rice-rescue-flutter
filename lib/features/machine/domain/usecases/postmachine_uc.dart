import 'package:dartz/dartz.dart';
import 'package:vhack_client/features/machine/domain/entity/machine_entity.dart';
import 'package:vhack_client/features/machine/domain/repositories/machine_repo.dart';
import 'package:vhack_client/shared/constant/cutom_res.dart';

class PostMachineUC {
  final MachineRepo machineRepo;

  PostMachineUC({required this.machineRepo});

  Future<Either<String, ResponseData>> call(MachineEntity machineEntity) {
    return machineRepo.postMachine(machineEntity);
  }
}
