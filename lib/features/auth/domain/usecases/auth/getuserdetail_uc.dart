import '../../repositories/user_repo.dart';

class GetUserDetailUC {
  final UserRepo userRepo;
  GetUserDetailUC({required this.userRepo});

  Future<String?> call() => userRepo.getUserData();
}
