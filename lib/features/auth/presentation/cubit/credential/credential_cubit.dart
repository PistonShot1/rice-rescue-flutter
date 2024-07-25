import 'dart:io';

import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';

import '../../../../../shared/constant/custom_snackbar.dart';
import '../../../../../shared/constant/cutom_res.dart';
import '../../../domain/entity/user_entity.dart';
import '../../../domain/usecases/credential/signin_uc.dart';
import '../../../domain/usecases/credential/signup_uc.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final SignInUC signInUC;
  final SignUpUC signUpUC;
  CredentialCubit({required this.signInUC, required this.signUpUC})
      : super(CredentialInitial());

  Future<void> signIn({required UserEntity userEntity}) async {
    emit(CredentialLoading());
    try {
      final response = await signInUC.call(UserEntity(
          userEmail: userEntity.userEmail,
          userPassword: userEntity.userPassword));

      determineResponse(response);
    } on SocketException catch (e) {
      handleError(e);
    } catch (e) {
      handleError(e);
    }
  }

  Future<void> signUp({required UserEntity userEntity}) async {
    emit(CredentialLoading());
    try {
      final user = UserEntity(
          userEmail: userEntity.userEmail,
          userPassword: userEntity.userPassword,
          userName: userEntity.userName,
          userAge: userEntity.userAge,
          userDesc: userEntity.userDesc,
          userType: userEntity.userType,
          userRole: userEntity.userRole,
          userExp: userEntity.userExp);
      final result = await signUpUC.call(user);
      result.fold((l) => handleError(l), (r) {
        handleResponse(r);
      });
      // determineResponseRegister(result);
    } on SocketException catch (e) {
      handleError(e);
    } catch (e) {
      handleError(e);
    }
  }

  void determineResponse(String response) {
    switch (response) {
      case 'Uncompleted Filled':
        handleError(response);
        break;
      case 'Email not found':
        handleError(response);
        break;
      case 'Password not matched':
        handleError(response);
        break;
      default:
        SnackBarUtil.showSnackBar(response, Colors.green.shade400);
        emit(CredentialSuccess());
    }
  }

  void handleResponse(ResponseData response) {
    String message = response.message;
    int status = response.status;

    debugPrint('Message: $message, Status: $status');

    if (status < 210) {
      debugPrint('Success: $message');
      SnackBarUtil.showSnackBar(message, Colors.green);
      emit(CredentialSuccess());
    } else {
      handleError(message);
    }
  }

  void handleError(dynamic error) {
    emit(CredentialFailure(failureTitle: error.toString()));
    debugPrint('Credential Cubit: ${error.toString()}');
    SnackBarUtil.showSnackBar(error.toString(), Colors.red);
  }
}
