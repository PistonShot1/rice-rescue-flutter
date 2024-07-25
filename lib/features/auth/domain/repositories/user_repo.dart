import 'package:dartz/dartz.dart';
import 'package:vhack_client/features/auth/domain/entity/user_entity.dart';
import 'package:vhack_client/shared/constant/cutom_res.dart';

abstract class UserRepo {
  Future<String> signIn(UserEntity userEntity);
  Future<Either<String, ResponseData>> signUp(UserEntity userEntity);
  Future<String?> getUserData();
  Future<void> signOut();

  Future<List<UserEntity>> getUsers();
  Future<UserEntity?> getSingleUser(UserEntity userEntity);
}
