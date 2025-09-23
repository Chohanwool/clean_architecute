import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:clean_arch_2/src/features/auth/presentation/provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  static String email = '';
  static String password = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginViewModelProvider);
    final registerState = ref.watch(registerViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Email"),
              onChanged: (val) => email = val,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
              onChanged: (val) => password = val,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(loginViewModelProvider.notifier)
                    .login(email, password);
              },
              child: loginState.isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Login"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(registerViewModelProvider.notifier)
                    .register(email, password);
              },
              child: const Text("Register"),
            ),
            loginState.when(
              data: (success) => success
                  ? const Text("✅ Login Success")
                  : const Text("❌ Login Failed"),
              loading: () => const Text("⏳ Logging in..."),
              error: (e, _) => Text("Error: $e"),
            ),
            registerState.when(
              data: (success) => success
                  ? const Text("✅ Register Success")
                  : const Text("❌ Register Failed"),
              loading: () => const Text("⏳ Registering..."),
              error: (e, _) => Text("Error: $e"),
            ),
          ],
        ),
      ),
    );
  }
}
