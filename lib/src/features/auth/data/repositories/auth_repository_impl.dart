import 'package:clean_arch_2/src/features/auth/domain/repositories/auth_repository.dart';

/// AuthRepository 인터페이스 추상메서드 구현 필수!!
class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<bool> login(String email, String password) async {
    // TODO: Firebase Auth 연동 예정
    await Future.delayed(const Duration(milliseconds: 1000));
    return email == 'test@test.com' && password == '1234';
  }

  @override
  Future<bool> register(String email, String password) async {
    // TODO: Firebase Auth 연동 예정
    await Future.delayed(const Duration(milliseconds: 1000));
    return true;
  }
}
