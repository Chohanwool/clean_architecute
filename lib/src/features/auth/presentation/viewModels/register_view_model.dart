import 'dart:async';

import 'package:clean_arch_2/src/features/auth/presentation/providers/register_user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterViewModel extends AsyncNotifier<bool> {
  @override
  FutureOr<bool> build() {
    return false;
  }

  Future<void> register(String email, String password) async {
    state = const AsyncLoading();

    try {
      // 1. usecase 읽어오기
      final registerUser = ref.read(registerUserProvider);

      // 2. usecase 호출
      final result = await registerUser(email, password);

      // 3. 결과를 상태에 저장
      state = AsyncData(result);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final registerViewModelProvider =
    AsyncNotifierProvider<RegisterViewModel, bool>(RegisterViewModel.new);
