import 'package:dartz/dartz.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:vhack_client/features/team/data/database/forum_remote_database.dart';
import 'package:vhack_client/features/team/data/model/forum_model.dart';
import 'package:vhack_client/features/team/domain/entity/forum_entity.dart';
import 'package:vhack_client/features/team/domain/repositories/forum_repo.dart';
import 'package:vhack_client/shared/constant/cutom_res.dart';

class ForumRepoImpl implements ForumRepo {
  final ForumRemoteDatabase forumRemoteDatabase;

  ForumRepoImpl({required this.forumRemoteDatabase});

  @override
  Future<Either<String, ResponseData>> deleteForum(String forumID) async {
    try {
      return Right(await forumRemoteDatabase.deleteForum(forumID));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ForumEntity>>> getForums() async {
    try {
      final forums = await forumRemoteDatabase.getForums();
      return Right(forums.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ResponseData>> postForum(
      ForumEntity forumEntity) async {
    try {
      return Right(await forumRemoteDatabase
          .postForum(ForumModel.fromEntity(forumEntity)));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
