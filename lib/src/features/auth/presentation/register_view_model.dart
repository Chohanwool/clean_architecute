import 'dart:async';

import 'package:clean_arch_2/src/features/auth/presentation/provider.dart';
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

      final result = await registerUser(email, password);

      state = AsyncData(result);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
