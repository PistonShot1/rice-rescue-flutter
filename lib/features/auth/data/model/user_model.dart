import 'package:equatable/equatable.dart';
import 'package:vhack_client/shared/util/avatar_data.dart';

import '../../domain/entity/user_entity.dart';

class UserModel extends Equatable {
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

  const UserModel({
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

  Map<String, dynamic> toJson() => <String, dynamic>{
        'userID': userID ?? '',
        'userEmail': userEmail ?? '',
        'userName': userName ?? '',
        'userPassword': userPassword ?? '',
        'userAge': userAge ?? 0,
        'userDesc': userDesc ?? '',
        'userType': userType ?? '',
        'userRole': userRole ?? '',
        'userExp': userExp ?? '',
        'userAvatar': userAvatar!.toJson(),
        'userCreatedAt': userCreatedAt?.toIso8601String() ??
            DateTime.now().toIso8601String(),
        'userUpdatedAt': userUpdatedAt?.toIso8601String() ??
            DateTime.now().toIso8601String(),
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userID: json['userID'],
        userEmail: json['userEmail'],
        userName: json['userName'],
        userPassword: json['userPassword'],
        userAge: json['userAge'],
        userDesc: json['userDesc'],
        userType: json['userType'],
        userRole: json['userRole'],
        userExp: json['userExp'],
        userToken: json['userToken'],
        userAvatar: AvatarData.fromJson(json['userAvatar']),
        userCreatedAt: json['userCreatedAt'] != null
            ? DateTime.parse(json['userCreatedAt'])
            : null,
        userUpdatedAt: json['userUpdatedAt'] != null
            ? DateTime.parse(json['userUpdatedAt'])
            : null,
      );

  UserEntity toEntity() => UserEntity(
        userID: userID,
        userEmail: userEmail,
        userName: userName,
        userPassword: userPassword,
        userAge: userAge,
        userDesc: userDesc,
        userType: userType,
        userRole: userRole,
        userExp: userExp,
        userToken: userToken,
        userAvatar: userAvatar,
        userCreatedAt: userCreatedAt,
        userUpdatedAt: userUpdatedAt,
      );

  factory UserModel.fromEntity(UserEntity userEntity) => UserModel(
        userID: userEntity.userID,
        userEmail: userEntity.userEmail,
        userName: userEntity.userName,
        userPassword: userEntity.userPassword,
        userAge: userEntity.userAge,
        userDesc: userEntity.userDesc,
        userType: userEntity.userType,
        userRole: userEntity.userRole,
        userExp: userEntity.userExp,
        userToken: userEntity.userToken,
        userAvatar: userEntity.userAvatar,
        userCreatedAt: userEntity.userCreatedAt,
        userUpdatedAt: userEntity.userUpdatedAt,
      );
}
