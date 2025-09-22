import 'package:clean_arch_2/src/features/auth/domain/usecases/login_user.dart';
import 'package:clean_arch_2/src/features/auth/domain/usecases/register_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:clean_arch_2/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:clean_arch_2/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:clean_arch_2/src/features/auth/presentation/login_view_model.dart';

// Repository Provider
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(),
);

//-- Repository Provider

//-- Usecase Provider
final loginUserProvider = Provider<LoginUser>(
  (ref) => LoginUser(ref.read(authRepositoryProvider)),
);

final registerUserProvider = Provider<RegisterUser>(
  (ref) => RegisterUser(ref.read(authRepositoryProvider)),
);

//-- Usecase Provider

// ViewModel Provider
final loginViewModelProvider = AsyncNotifierProvider<LoginViewModel, bool>(
  LoginViewModel.new,
);

//-- ViewModel Provider
