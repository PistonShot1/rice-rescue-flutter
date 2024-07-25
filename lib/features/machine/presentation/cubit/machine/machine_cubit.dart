import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:vhack_client/features/machine/domain/entity/machine_entity.dart';
import 'package:vhack_client/features/machine/domain/usecases/deletemachine_uc.dart';
import 'package:vhack_client/features/machine/domain/usecases/getmachines_uc.dart';
import 'package:vhack_client/features/machine/domain/usecases/postmachine_uc.dart';
import 'package:vhack_client/features/machine/domain/usecases/updatemachine_uc.dart';

import '../../../../../shared/constant/custom_snackbar.dart';
import '../../../../../shared/constant/cutom_res.dart';

part 'machine_state.dart';

class MachineCubit extends Cubit<MachineState> {
  final PostMachineUC postMachineUC;
  final DeleteMachineUC deleteMachineUC;
  final GetMachinesUC getMachinesUC;
  final UpdateMachineUC updateMachineUC;
  MachineCubit(
      {required this.postMachineUC,
      required this.deleteMachineUC,
      required this.getMachinesUC,
      required this.updateMachineUC})
      : super(MachineInitial());

  Future<void> postMachine({
    required MachineEntity machineEntity,
  }) async {
    try {
      final result = await postMachineUC.call(machineEntity);
      result.fold((l) => emit(MachineFailure(failureTitle: l.toString())), (r) {
        handleResponse(r);
        getMachines();
      });
    } catch (e) {
      handleError(e);
    }
  }

  Future<void> deleteMachine({required MachineEntity machineEntity}) async {
    try {
      final result = await deleteMachineUC.call(machineEntity);
      result.fold((l) => emit(MachineFailure(failureTitle: l.toString())), (r) {
        handleResponse(r);
        getMachines();
      });
    } catch (e) {
      handleError(e);
    }
  }

  Future<void> updateMachine({required MachineEntity machineEntity}) async {
    try {
      final result = await updateMachineUC.call(machineEntity);
      result.fold((l) => emit(MachineFailure(failureTitle: l)), (r) {
        handleResponse(r);
        getMachines();
      });
    } catch (e) {
      handleError(e);
    }
  }

  Future<void> getMachines() async {
    emit(MachineLoading());
    try {
      final result = await getMachinesUC.call();
      result.fold((l) => emit(MachineFailure(failureTitle: l.toString())), (r) {
        if (r.isEmpty) {
          emit(const MachineEmpty(emptyTitle: 'Nothing to show here'));
        } else {
          emit(MachineLoaded(machines: r));
        }
      });
    } catch (e) {
      handleError(e);
    }
  }

  List<MachineEntity> selectedMachines = [];

  bool isSelected(MachineEntity machineEntity) {
    if (selectedMachines.contains(machineEntity)) {
      return true;
    } else {
      return false;
    }
  }

  void selectMachine(MachineEntity machineEntity) {
    isSelected(machineEntity)
        ? selectedMachines.remove(machineEntity)
        : selectedMachines.add(machineEntity);
  }

  void reset() {
    selectedMachines.clear();
  }

  void handleResponse(ResponseData response) {
    String message = response.message;
    int status = response.status;

    debugPrint('Message: $message, Status: $status');

    if (status < 210) {
      debugPrint('Success: $message');
      SnackBarUtil.showSnackBar(message, Colors.green);
    } else {
      debugPrint('Failure: $message');
      SnackBarUtil.showSnackBar(message, Colors.red);
      emit(MachineFailure(failureTitle: message));
    }
  }

  void handleError(final response) {
    emit(MachineFailure(failureTitle: response.toString()));
    debugPrint('Machine Cubit: ${response.toString()}');
    SnackBarUtil.showSnackBar(response.toString(), Colors.red);
  }
}
