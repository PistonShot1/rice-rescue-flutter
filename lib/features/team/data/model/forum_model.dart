import 'package:equatable/equatable.dart';
import 'package:vhack_client/features/auth/data/model/user_model.dart';

import '../../domain/entity/forum_entity.dart';

class ForumModel extends Equatable {
  final String? forumID, forumContent, forumByID, forumLocation;
  final DateTime? forumAt;
  final UserModel? forumBy;

  const ForumModel(
      {this.forumID,
      this.forumContent,
      this.forumByID,
      this.forumLocation,
      this.forumAt,
      this.forumBy});

  factory ForumModel.fromJson(Map<String, dynamic> json) {
    return ForumModel(
      forumID: json['forumID'],
      forumContent: json['forumContent'],
      forumByID: json['forumByID'],
      forumLocation: json['forumLocation'],
      forumAt: DateTime.parse(json['forumAt']),
      forumBy: UserModel.fromJson(json['forumBy']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'forumContent': forumContent,
      'forumByID': forumByID,
      'forumLocation': forumLocation,
    };
  }

  factory ForumModel.fromEntity(ForumEntity entity) {
    return ForumModel(
      forumID: entity.forumID,
      forumContent: entity.forumContent,
      forumByID: entity.forumByID,
      forumLocation: entity.forumLocation,
      forumAt: entity.forumAt,
      forumBy:
          entity.forumBy != null ? UserModel.fromEntity(entity.forumBy!) : null,
    );
  }

  ForumEntity toEntity() {
    return ForumEntity(
      forumID: forumID,
      forumContent: forumContent,
      forumByID: forumByID,
      forumLocation: forumLocation,
      forumAt: forumAt,
      forumBy: forumBy?.toEntity(),
    );
  }

  @override
  List<Object?> get props =>
      [forumID, forumContent, forumByID, forumLocation, forumAt, forumBy];
}
