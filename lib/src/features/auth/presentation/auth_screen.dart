import 'package:clean_arch_2/src/features/auth/presentation/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clean_arch_2/src/features/auth/presentation/providers/login_mode_provider.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _formKey = GlobalKey<FormState>();

  String _enteredEmail = '';
  String _enteredPassword = '';

  void _submitForm(bool isLoginState) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (isLoginState) {
        ref
            .read(loginViewModelProvider.notifier)
            .login(_enteredEmail, _enteredPassword);
      } else {
        ref
            .read(registerViewModelProvider.notifier)
            .register(_enteredEmail, _enteredPassword);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLoginState = ref.watch(isLoginModeProvider);
    final loginState = ref.watch(loginViewModelProvider);
    final registerState = ref.watch(registerViewModelProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                margin: const EdgeInsets.all(20.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Email Address',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains('@')) {
                              return 'Please enter a valid email address';
                            }

                            return null;
                          },
                          onSaved: (newValue) => _enteredEmail = newValue ?? '',
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.trim().length < 6) {
                              return 'Password must be at least 6 characters long';
                            }

                            return null;
                          },
                          onSaved: (newValue) => _enteredPassword = newValue!,
                        ),
                        const SizedBox(height: 12.0),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                              foregroundColor: Theme.of(
                                context,
                              ).colorScheme.onPrimary,
                            ),
                            onPressed: () {
                              _submitForm(isLoginState);
                            },
                            child: Text(isLoginState ? 'Sign In' : 'Sign Up'),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            ref
                                .read(isLoginModeProvider.notifier)
                                .toggleLoginMode();
                          },
                          child: Text(
                            isLoginState
                                ? 'Create an account'
                                : 'I already have an account',
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        _buildResultDisplay(
                          isLoginState,
                          loginState,
                          registerState,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultDisplay(
    bool isLoginState,
    AsyncValue<bool> loginState,
    AsyncValue<bool> registerState,
  ) {
    final currentState = isLoginState ? loginState : registerState;

    // 로딩 중일 때만 표시
    if (currentState.isLoading) {
      return Text("⏳ ${isLoginState ? 'Logging in...' : 'Registering...'}");
    }

    // 에러가 있을 때만 표시
    if (currentState.hasError) {
      return Text(
        "${isLoginState ? 'Login' : 'Register'} Error: ${currentState.error}",
        style: const TextStyle(color: Colors.red),
      );
    }

    // 성공/실패는 실제로 시도한 후에만 표시
    if (currentState.hasValue && currentState.value != null) {
      final success = currentState.value!;
      final message = isLoginState
          ? (success ? "✅ Login Success" : "❌ Login Failed")
          : (success ? "✅ Register Success" : "❌ Register Failed");
      final color = success ? Colors.green : Colors.red;
      return Text(message, style: TextStyle(color: color));
    }

    return const SizedBox.shrink(); // 초기 상태에서는 아무것도 표시하지 않음
  }
}
