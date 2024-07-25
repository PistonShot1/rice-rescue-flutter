import 'package:dartz/dartz.dart';
import 'package:vhack_client/features/auth/data/database/user_remote_database.dart';
import 'package:vhack_client/features/auth/domain/entity/user_entity.dart';
import 'package:vhack_client/features/auth/domain/repositories/user_repo.dart';
import 'package:vhack_client/shared/constant/cutom_res.dart';

import '../model/user_model.dart';

class UserRepoImpl implements UserRepo {
  final UserRemoteDatabase userRemoteDatabase;

  UserRepoImpl({required this.userRemoteDatabase});

  @override
  Future<String?> getUserData() async {
    final userToReturn = await userRemoteDatabase.getUserData();
    return userToReturn;
  }

  @override
  Future<String> signIn(UserEntity userEntity) async {
    final userToInsert = UserModel.fromEntity(userEntity);
    final userToReturn = await userRemoteDatabase.signIn(userToInsert);
    return userToReturn;
  }

  @override
  Future<void> signOut() async {
    await userRemoteDatabase.signOut();
  }

  @override
  Future<Either<String, ResponseData>> signUp(UserEntity userEntity) async {
    try {
      final userToInsert = UserModel.fromEntity(userEntity);
      final userToReturn = await userRemoteDatabase.signUp(userToInsert);
      return Right(userToReturn);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<UserEntity?> getSingleUser(UserEntity userEntity) async {
    final userToInsert = UserModel.fromEntity(userEntity);
    final userToReturn = await userRemoteDatabase.getSingleUser(userToInsert);
    return userToReturn!.toEntity();
  }

  @override
  Future<List<UserEntity>> getUsers() async {
    final List<UserModel> userModels = await userRemoteDatabase.getUsers();
    final List<UserEntity> userEntities =
        userModels.map((userModel) => userModel.toEntity()).toList();
    return userEntities;
  }
}
