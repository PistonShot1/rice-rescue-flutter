import 'package:equatable/equatable.dart';
import 'package:vhack_client/features/auth/domain/entity/user_entity.dart';

class ForumEntity extends Equatable {
  final String? forumID, forumContent, forumByID, forumLocation;
  final DateTime? forumAt;
  final UserEntity? forumBy;

  const ForumEntity(
      {this.forumID,
      this.forumContent,
      this.forumByID,
      this.forumLocation,
      this.forumAt,
      this.forumBy});

  @override
  List<Object?> get props =>
      [forumID, forumContent, forumByID, forumLocation, forumAt, forumBy];
}
