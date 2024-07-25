import 'package:dartz/dartz.dart';
import 'package:vhack_client/features/team/domain/entity/forum_entity.dart';
import 'package:vhack_client/shared/constant/cutom_res.dart';

abstract class ForumRepo {
  Future<Either<String, ResponseData>> postForum(ForumEntity forumEntity);
  Future<Either<String, ResponseData>> deleteForum(String forumID);
  Future<Either<String, List<ForumEntity>>> getForums();
}
