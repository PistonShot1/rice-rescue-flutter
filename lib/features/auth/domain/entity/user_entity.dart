import 'package:equatable/equatable.dart';
import 'package:vhack_client/shared/util/avatar_data.dart';

class UserEntity extends Equatable {
  final String? userID;
  final String? userEmail;
  final String? userName;
  final String? userPassword;
  final int? userAge;

  final String? userDesc;
  final String? userType;
  final String? userRole;
  final String? userExp;
  final String? userToken;
  final AvatarData? userAvatar;
  final DateTime? userCreatedAt;
  final DateTime? userUpdatedAt;

  const UserEntity({
    this.userID,
    this.userEmail,
    this.userName,
    this.userPassword,
    this.userAge,
    this.userDesc,
    this.userType,
    this.userRole,
    this.userExp,
    this.userToken,
    this.userAvatar,
    this.userCreatedAt,
    this.userUpdatedAt,
  });

  @override
  List<Object?> get props => [
        userID,
        userEmail,
        userName,
        userPassword,
        userAge,
        userDesc,
        userType,
        userRole,
        userExp,
        userToken,
        userAvatar,
        userCreatedAt,
        userUpdatedAt,
      ];
}
