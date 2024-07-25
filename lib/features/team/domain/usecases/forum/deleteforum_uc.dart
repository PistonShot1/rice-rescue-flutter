import 'package:dartz/dartz.dart';
import 'package:vhack_client/features/team/domain/entity/forum_entity.dart';
import 'package:vhack_client/features/team/domain/repositories/forum_repo.dart';
import 'package:vhack_client/shared/constant/cutom_res.dart';

class DeleteForumUC {
  final ForumRepo forumRepo;

  DeleteForumUC({required this.forumRepo});

  Future<Either<String, ResponseData>> call(String forumID) {
    return forumRepo.deleteForum(forumID);
  }
}
