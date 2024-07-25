import 'package:dartz/dartz.dart';
import 'package:vhack_client/features/team/domain/entity/forum_entity.dart';
import 'package:vhack_client/features/team/domain/repositories/forum_repo.dart';
import 'package:vhack_client/shared/constant/cutom_res.dart';

class PostForumUC {
  final ForumRepo forumRepo;

  PostForumUC({required this.forumRepo});

  Future<Either<String, ResponseData>> call(ForumEntity forumEntity) {
    return forumRepo.postForum(forumEntity);
  }
}
