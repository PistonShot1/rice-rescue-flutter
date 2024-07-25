import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:vhack_client/features/auth/domain/entity/user_entity.dart';
import 'package:vhack_client/features/auth/domain/usecases/user/getusers_uc.dart';

import '../../../../../shared/constant/custom_snackbar.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUsersUC getUsersUC;
  UserCubit({required this.getUsersUC}) : super(UserInitial());

  Future<void> getUsers() async {
    try {
      final response = await getUsersUC.call();
      if (response.isEmpty) {
        emit(const UserEmpty(emptyTitle: 'Nothing to show here'));
      } else {
        emit(UserLoaded(users: response));
      }
    } catch (e) {
      handleResponse(e);
    }
  }

  List<UserEntity> selectedUsers = [];

  bool isSelected(UserEntity userEntity) {
    if (selectedUsers.contains(userEntity)) {
      return true;
    } else {
      return false;
    }
  }

  void selectUser(UserEntity selectedUser) {
    if (isSelected(selectedUser)) {
      selectedUsers.remove(selectedUser);
    } else {
      selectedUsers.add(selectedUser);
    }
  }

  void reset() {
    selectedUsers.clear();
  }

  void handleResponse(dynamic error) {
    emit(UserFailure(failureTitle: error.toString()));
    debugPrint('User Cubit: ${error.toString()}');
    SnackBarUtil.showSnackBar(error.toString(), Colors.red);
  }
}
