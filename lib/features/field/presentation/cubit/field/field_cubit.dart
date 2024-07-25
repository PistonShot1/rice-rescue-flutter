import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:vhack_client/features/field/data/model/field_model.dart';
import 'package:vhack_client/features/field/domain/entity/field_entity.dart';
import 'package:vhack_client/features/field/domain/usecase/deletefield_uc.dart';
import 'package:vhack_client/features/field/domain/usecase/getfields_uc.dart';
import 'package:vhack_client/features/field/domain/usecase/postfield_uc.dart';
import 'package:vhack_client/presentation/components/card/field/field_card.dart';
import 'package:vhack_client/shared/constant/cutom_res.dart';

import '../../../../../shared/constant/custom_snackbar.dart';

part 'field_state.dart';

class FieldCubit extends Cubit<FieldState> {
  final PostFieldUC postFieldUC;
  final DeleteFieldUC deleteFieldUC;
  final GetFieldsdUC getFieldsdUC;

  FieldCubit(
      {required this.postFieldUC,
      required this.deleteFieldUC,
      required this.getFieldsdUC})
      : super(FieldInitial());

  Future<void> postField({required FieldEntity fieldEntity}) async {
    final result = await postFieldUC.call(FieldEntity(
        fieldName: fieldEntity.fieldName,
        fieldCA: fieldEntity.fieldCA,
        fieldOwnerID: fieldEntity.fieldOwnerID,
        fieldPCT: fieldEntity.fieldPCT,
        fieldSeedDate: fieldEntity.fieldSeedDate,
        locationEntity: fieldEntity.locationEntity,
        fieldSTEntity: FieldSTEntity(
            stPrev: [],
            stTime: [],
            stCurrent: 0.2,
            stLocation: fieldEntity.locationEntity!),
        fieldSMEntity: FieldSMEntity(
            smPrev: [],
            smTime: [],
            smCurrent: 0.2,
            smLocation: fieldEntity.locationEntity!)));
    handleResponse(result);
  }

  Future<void> deleteField({required String fieldID}) async {
    final result = await deleteFieldUC.call(fieldID);
    final fields = await getFieldsdUC.call();
    emit(FieldLoaded(fields: fields));
    handleResponse(result);
  }

  Future<void> getFields() async {
    try {
      final fields = await getFieldsdUC.call();
      emit(FieldLoaded(fields: fields));
    } catch (e) {
      handleError(e);
    }
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
      emit(FieldFailure(failureTitle: message));
    }
  }

  void handleError(final response) {
    emit(FieldFailure(failureTitle: response.toString()));
    debugPrint('Field Cubit: ${response.toString()}');
    SnackBarUtil.showSnackBar(response.toString(), Colors.red);
  }
}
