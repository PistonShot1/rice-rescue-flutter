import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:vhack_client/features/crop/domain/entity/crop_entity.dart';
import 'package:vhack_client/features/crop/domain/usecases/deletecrop_uc.dart';
import 'package:vhack_client/features/crop/domain/usecases/getcrops_uc.dart';
import 'package:vhack_client/features/crop/domain/usecases/postcrop_uc.dart';

import '../../../../../shared/constant/custom_snackbar.dart';
import '../../../../../shared/constant/cutom_res.dart';

part 'crop_state.dart';

class CropCubit extends Cubit<CropState> {
  final PostCropUC postCropUC;
  final DeleteCropUC deleteCropUC;
  final GetCropsUC getCropsUC;

  CropCubit(
      {required this.postCropUC,
      required this.deleteCropUC,
      required this.getCropsUC})
      : super(CropInitial());

  Future<void> postCrop({required CropEntity cropEntity}) async {
    try {
      final result = await postCropUC.call(cropEntity);
      result.fold((l) => emit(CropFailure(failureTitle: l)), (r) {
        handleResponse(r);
        getCropsUC();
      });
    } catch (e) {
      handleError(e);
    }
  }

  Future<void> deleteCrop({required CropEntity cropEntity}) async {
    try {
      final result = await deleteCropUC.call(cropEntity);
      result.fold((l) => emit(CropFailure(failureTitle: l)), (r) async {
        await getCrops();
        handleResponse(r);
      });
    } catch (e) {
      handleError(e);
    }
  }

  Future<void> getCrops() async {
    emit(CropLoading());
    try {
      final result = await getCropsUC.call();
      result.fold((l) => emit(CropFailure(failureTitle: l)), (r) {
        if (r.isEmpty) {
          emit(const CropEmpty(emptyTitle: 'Oops nothing to show here.'));
        } else {
          emit(CropLoaded(crops: r));
        }
      });
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
      emit(CropFailure(failureTitle: message));
    }
  }

  void handleError(final response) {
    emit(CropFailure(failureTitle: response.toString()));
    debugPrint('Crop Cubit: ${response.toString()}');
    SnackBarUtil.showSnackBar(response.toString(), Colors.red);
  }
}
