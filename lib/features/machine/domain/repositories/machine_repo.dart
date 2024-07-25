import 'package:dartz/dartz.dart';
import 'package:vhack_client/features/machine/domain/entity/machine_entity.dart';

import '../../../../shared/constant/cutom_res.dart';

abstract class MachineRepo {
  Future<Either<String, ResponseData>> postMachine(MachineEntity machineEntity);
  Future<Either<String, ResponseData>> deleteMachine(
      MachineEntity machineEntity);
  Future<Either<String, List<MachineEntity>>> getMachines();
  Future<Either<String, ResponseData>> updateMachine(
      MachineEntity machineEntity);
}
