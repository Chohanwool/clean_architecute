import 'package:clean_arch_2/src/core/dummy_data.dart';
import 'package:clean_arch_2/src/features/auth/domain/entities/user.dart';
import 'package:clean_arch_2/src/features/auth/domain/repositories/auth_repository.dart';

/// AuthRepository 인터페이스 추상메서드 구현 필수!!
class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<bool> login(String email, String password) async {
    // TODO: Firebase Auth 연동 예정
    await Future.delayed(const Duration(milliseconds: 1000));

    return dummyUsers.firstWhere(
          (user) => user.email == email && user.password == password,
        ) !=
        null;
  }

  @override
  Future<bool> register(String email, String password) async {
    // TODO: Firebase Auth 연동 예정
    await Future.delayed(const Duration(milliseconds: 1000));

    if (dummyUsers.any((user) => user.email == email)) return false;

    dummyUsers.add(User(email: email, password: password));
    return true;
  }
}
