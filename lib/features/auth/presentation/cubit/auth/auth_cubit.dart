import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../shared/constant/custom_snackbar.dart';
import '../../../domain/usecases/auth/getuserdetail_uc.dart';
import '../../../domain/usecases/credential/signout_uc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetUserDetailUC getUserDetailUC;
  final SignOutUC signOutUC;
  AuthCubit({required this.getUserDetailUC, required this.signOutUC})
      : super(AuthInitial());

  Future<void> getUserDetail({required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('Authorization');

      final userID = await getUserDetailUC.call();
      if (userID == null || token == null) {
        emit(UnAuthenticated());
      } else {
        emit(Authenticated(userID: userID));
      }
    } catch (e) {
      handleError(e);
    }
  }

  Future<void> signOut() async {
    try {
      await signOutUC.call();
      emit(UnAuthenticated());
    } catch (e) {
      handleError(e);
    }
  }

  void handleError(dynamic error) {
    debugPrint('Auth Cubit: ${error.toString()}');
    emit(AuthenticatedFailed(failureTitle: error.toString()));
  }
}
