import 'package:clean_arch_2/src/features/auth/domain/repositories/auth_repository.dart';

///
class LoginUser {
  LoginUser(this.repository);

  final AuthRepository repository;

  /// call 함수 : 클래스의 인스턴스를 함수처럼 호출 가능
  /// 예시) LgoinUser('test@test.com', '1234');
  ///       - LoginUser.login('test@test.com', '1234');
  Future<bool> call(String email, String password) async {
    return await repository.login(email, password);
  }
}
