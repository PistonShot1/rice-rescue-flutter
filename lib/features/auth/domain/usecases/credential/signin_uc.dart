import '../../entity/user_entity.dart';
import '../../repositories/user_repo.dart';

class SignInUC {
  final UserRepo userRepo;
  SignInUC({required this.userRepo});

  Future<String> call(UserEntity userEntity) => userRepo.signIn(userEntity);
}
