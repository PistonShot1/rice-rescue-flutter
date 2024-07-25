import 'package:dartz/dartz.dart';
import 'package:vhack_client/features/team/domain/entity/forum_entity.dart';
import 'package:vhack_client/features/team/domain/repositories/forum_repo.dart';

class GetForumUC {
  final ForumRepo forumRepo;

  GetForumUC({required this.forumRepo});

  Future<Either<String, List<ForumEntity>>> call() {
    return forumRepo.getForums();
  }
}
