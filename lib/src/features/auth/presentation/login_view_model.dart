import 'dart:async';

import 'package:clean_arch_2/src/features/auth/presentation/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifier
class LoginViewModel extends AsyncNotifier<bool> {
  @override
  FutureOr<bool> build() {
    return false;
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();

    try {
      // 1. UseCase 읽어오기
      final loginUser = ref.read(loginUserProvider);

      // 2. Usecas인 LoginUser의 call 메서드 호출
      final result = await loginUser(email, password);
      //    ↓
      //    LoginUser.call() → AuthRepositoryImpl.login() → 실제 결과
      //    ↓
      //    result = true 또는 false

      // 3. 결과를 상태에 저장
      state = AsyncData(result);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
