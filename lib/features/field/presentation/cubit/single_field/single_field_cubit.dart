import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vhack_client/features/field/domain/entity/field_entity.dart';
import 'package:vhack_client/features/field/domain/usecase/getsinglefield_uc.dart';

import '../../../../../shared/constant/custom_snackbar.dart';

part 'single_field_state.dart';

class SingleFieldCubit extends Cubit<SingleFieldState> {
  final GetSingleFieldUC getSingleFieldUC;

  SingleFieldCubit({required this.getSingleFieldUC})
      : super(SingleFieldInitial());

  Future<void> getSingleField({required FieldEntity fieldEntity}) async {
    final fieldentity = await getSingleFieldUC.call(fieldEntity);
    if (fieldentity == null) {
      emit(SingleFieldEmpty(emptyTitle: 'Oops field not found'));
    } else {
      print(
          'Field Name: ${fieldEntity.fieldName} and ${fieldEntity.fieldSTEntity!.stPrev}');
      emit(SingleFieldLoaded(fieldEntity: fieldEntity));
    }
  }

  void handleError(final response) {
    emit(SingleFieldFailure(failureTitle: response.toString()));
    debugPrint('Single Field Cubit: ${response.toString()}');
    SnackBarUtil.showSnackBar(response.toString(), Colors.red);
  }
}
