import 'package:dartz/dartz.dart';
import 'package:vhack_client/features/machine/data/database/machine_remote_database.dart';
import 'package:vhack_client/features/machine/data/model/machine_model.dart';
import 'package:vhack_client/features/machine/domain/entity/machine_entity.dart';
import 'package:vhack_client/features/machine/domain/repositories/machine_repo.dart';
import 'package:vhack_client/shared/constant/cutom_res.dart';
import 'package:vhack_client/shared/util/exception_data.dart';

class MachineRepoImpl implements MachineRepo {
  final MachineRemoteDatabase machineRemoteDatabase;

  MachineRepoImpl({required this.machineRemoteDatabase});
  @override
  Future<Either<String, ResponseData>> deleteMachine(
      MachineEntity machineEntity) async {
    try {
      return Right(await machineRemoteDatabase
          .deleteMachine(MachineModel.fromEntity(machineEntity)));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<MachineEntity>>> getMachines() async {
    try {
      final machines = await machineRemoteDatabase.getMachines();
      return Right(machines.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ResponseData>> postMachine(
      MachineEntity machineEntity) async {
    try {
      return Right(await machineRemoteDatabase
          .postMachine(MachineModel.fromEntity(machineEntity)));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ResponseData>> updateMachine(
      MachineEntity machineEntity) async {
    try {
      return Right(await machineRemoteDatabase
          .updateMachine(MachineModel.fromEntity(machineEntity)));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
