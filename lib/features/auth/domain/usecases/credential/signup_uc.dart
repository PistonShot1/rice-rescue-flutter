import 'package:dartz/dartz.dart';
import 'package:vhack_client/shared/constant/cutom_res.dart';

import '../../entity/user_entity.dart';
import '../../repositories/user_repo.dart';

class SignUpUC {
  final UserRepo userRepo;
  SignUpUC({required this.userRepo});

  Future<Either<String, ResponseData>> call(UserEntity userEntity) =>
      userRepo.signUp(userEntity);
}
