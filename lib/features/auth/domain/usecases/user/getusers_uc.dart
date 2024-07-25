import 'package:vhack_client/features/auth/domain/entity/user_entity.dart';
import 'package:vhack_client/features/auth/domain/repositories/user_repo.dart';

class GetUsersUC {
  final UserRepo userRepo;

  GetUsersUC({required this.userRepo});

  Future<List<UserEntity>> call() {
    return userRepo.getUsers();
  }
}
