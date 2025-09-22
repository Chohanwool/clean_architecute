import 'package:clean_arch_2/src/features/auth/domain/repositories/auth_repository.dart';

class RegisterUser {
  RegisterUser(this.repository);

  final AuthRepository repository;

  Future<bool> call(String email, String password) async {
    return await repository.register(email, password);
  }
}
