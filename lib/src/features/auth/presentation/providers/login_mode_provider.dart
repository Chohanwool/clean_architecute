import 'package:flutter_riverpod/flutter_riverpod.dart';

// isLoginProvider
final isLoginModeProvider = NotifierProvider<IsLoginModeProvider, bool>(
  IsLoginModeProvider.new,
);

class IsLoginModeProvider extends Notifier<bool> {
  @override
  bool build() {
    return true;
  }

  void toggleLoginMode() {
    state = !state;
  }
}
