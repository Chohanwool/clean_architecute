abstract class AuthRemoteDatasource {
  Future<bool> login(String email, String password);
  Future<bool> register(String email, String password);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  // 가상 데이터
  static final Map<String, String> _dummyUsers = {'test@test.com': '1234'};

  @override
  Future<bool> login(String email, String password) async {
    // 가상 네트워크 지연 시뮬레이션
    await Future.delayed(const Duration(milliseconds: 1000));

    return _dummyUsers[email] == password;
  }

  @override
  Future<bool> register(String email, String password) async {
    // 가상 네트워크 지연 시뮬레이션
    await Future.delayed(const Duration(milliseconds: 1000));

    // 이미 존재하는지 확인 후, 리턴
    if (_dummyUsers.containsKey(email)) return false;

    // 새로운 사용자 추가
    _dummyUsers[email] = password;
    return true;
  }
}
