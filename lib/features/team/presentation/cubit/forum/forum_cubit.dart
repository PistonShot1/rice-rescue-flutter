import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:vhack_client/features/team/domain/entity/forum_entity.dart';
import 'package:vhack_client/features/team/domain/usecases/forum/deleteforum_uc.dart';
import 'package:vhack_client/features/team/domain/usecases/forum/getforum_uc.dart';
import 'package:vhack_client/features/team/domain/usecases/forum/postforum_uc.dart';
import 'package:vhack_client/shared/constant/custom_snackbar.dart';

import '../../../../../shared/constant/cutom_res.dart';

part 'forum_state.dart';

class ForumCubit extends Cubit<ForumState> {
  final PostForumUC postForumUC;
  final DeleteForumUC deleteForumUC;
  final GetForumUC getForumUC;
  ForumCubit(
      {required this.postForumUC,
      required this.deleteForumUC,
      required this.getForumUC})
      : super(ForumInitial());

  Future<void> postForum({required ForumEntity forumEntity}) async {
    try {
      final result = await postForumUC.call(forumEntity);
      result.fold((l) => emit(ForumFailure(failureTitle: l.toString())),
          (r) async {
        handleResponse(r);
        final forums = await getForumUC.call();
        forums.fold((l) => emit(ForumFailure(failureTitle: l.toString())), (r) {
          if (r.isEmpty) {
            emit(const ForumEmpty(emptyTitle: 'Nothing to show here'));
          } else {
            emit(ForumLoaded(forums: r));
          }
        });
      });
    } catch (e) {
      handleError(e);
    }
  }

  Future<void> deleteForum({required String forumID}) async {
    try {
      final result = await deleteForumUC.call(forumID);
      result.fold((l) => emit(ForumFailure(failureTitle: l.toString())),
          (r) async {
        handleResponse(r);
        final forums = await getForumUC.call();
        forums.fold((l) => emit(ForumFailure(failureTitle: l.toString())), (r) {
          if (r.isEmpty) {
            emit(const ForumEmpty(emptyTitle: 'Nothing to show here'));
          } else {
            emit(ForumLoaded(forums: r));
          }
        });
      });
    } catch (e) {
      handleError(e);
    }
  }

  Future<void> getForums() async {
    try {
      final result = await getForumUC.call();
      result.fold((l) => emit(ForumFailure(failureTitle: l.toString())), (r) {
        if (r.isEmpty) {
          emit(const ForumEmpty(emptyTitle: 'Nothing to show here'));
        } else {
          emit(ForumLoaded(forums: r));
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
      emit(ForumFailure(failureTitle: message));
    }
  }

  void handleError(final response) {
    emit(ForumFailure(failureTitle: response.toString()));
    debugPrint('Forum Cubit: ${response.toString()}');
    SnackBarUtil.showSnackBar(response.toString(), Colors.red);
  }
}
