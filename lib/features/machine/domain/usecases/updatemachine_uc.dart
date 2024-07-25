import 'package:dartz/dartz.dart';
import 'package:vhack_client/features/machine/domain/repositories/machine_repo.dart';

import '../../../../shared/constant/cutom_res.dart';
import '../entity/machine_entity.dart';

class UpdateMachineUC {
  final MachineRepo machineRepo;

  UpdateMachineUC({required this.machineRepo});

  Future<Either<String, ResponseData>> call(MachineEntity machineEntity) {
    return machineRepo.updateMachine(machineEntity);
  }
}
