import 'package:vhack_client/features/auth/domain/entity/user_entity.dart';
import 'package:vhack_client/features/auth/domain/repositories/user_repo.dart';

class GetSingleUserUC {
  final UserRepo userRepo;

  GetSingleUserUC({required this.userRepo});

  Future<UserEntity?> call(UserEntity userEntity) {
    return userRepo.getSingleUser(userEntity);
  }
}
