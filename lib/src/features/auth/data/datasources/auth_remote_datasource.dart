import 'package:clean_arch_2/src/core/dummy_data.dart';
import 'package:clean_arch_2/src/features/auth/domain/entities/user.dart';

abstract class AuthRemoteDatasource {
  Future<bool> login(String email, String password);
  Future<bool> register(String email, String password);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  @override
  Future<bool> login(String email, String password) async {
    // 가상 네트워크 지연 시뮬레이션
    await Future.delayed(const Duration(milliseconds: 1000));

    return dummyUsers.firstWhere(
          (user) => user.email == email && user.password == password,
        ) !=
        null;
  }

  @override
  Future<bool> register(String email, String password) async {
    // 가상 네트워크 지연 시뮬레이션
    await Future.delayed(const Duration(milliseconds: 1000));

    // 이미 존재하는지 확인 후, 리턴
    if (dummyUsers.any((user) => user.email == email)) return false;

    // 새로운 사용자 추가
    dummyUsers.add(User(email: email, password: password));
    return true;
  }
}
