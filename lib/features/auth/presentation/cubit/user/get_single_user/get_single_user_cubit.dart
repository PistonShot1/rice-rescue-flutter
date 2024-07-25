import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:vhack_client/features/auth/domain/entity/user_entity.dart';
import 'package:vhack_client/features/auth/domain/usecases/user/get_single_user_uc.dart';

import '../../../../../../shared/constant/custom_snackbar.dart';

part 'get_single_user_state.dart';

class GetSingleUserCubit extends Cubit<GetSingleUserState> {
  final GetSingleUserUC getSingleUserUC;
  GetSingleUserCubit({required this.getSingleUserUC})
      : super(GetSingleUserInitial());

  Future<void> getSingleUser({required UserEntity userEntity}) async {
    final result = await getSingleUserUC.call(userEntity);
    if (result == null) {
      emit(const GetSingleUserFailure(failureTitle: 'Cannot fetch user'));
    } else {
      emit(GetSingleUserLoaded(userEntity: result));
    }
  }

  void handleResponse(dynamic error) {
    emit(GetSingleUserFailure(failureTitle: error.toString()));
    debugPrint('User Cubit: ${error.toString()}');
    SnackBarUtil.showSnackBar(error.toString(), Colors.red);
  }
}
