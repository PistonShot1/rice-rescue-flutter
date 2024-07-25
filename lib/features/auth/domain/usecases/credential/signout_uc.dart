import '../../repositories/user_repo.dart';

class SignOutUC {
  final UserRepo userRepo;
  SignOutUC({required this.userRepo});

  Future<void> call() => userRepo.signOut();
}
