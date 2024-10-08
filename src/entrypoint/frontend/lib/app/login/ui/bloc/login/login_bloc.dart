import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/params/user_login_params.dart';
import '../../../data/repository/login_repository.dart';
import 'login_state.dart';

abstract class ILoginBloc extends Cubit<LoginState> {
  ILoginBloc() : super(LoginInitial());

  Future<void> login({
    required String email,
    required String password,
  });
}

class LoginBloc extends ILoginBloc {
  final ILoginRepository repository;
  final SharedPreferences sharedPreferences;

  LoginBloc({
    required this.repository,
    required this.sharedPreferences,
  });

  @override
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      final user = UserLoginParams(
        email: email,
        password: password,
      );

      final result = await repository.login(user: user);

      final token = result.access;

      await Future.wait([
        sharedPreferences.setString('email', email),
        if (token != null) sharedPreferences.setString('token', token),
      ]);

      emit(LoginSuccess(user: result));
    } catch (e) {
      emit(
        LoginFailure(
          message: 'Ocorreu um erro ao tentar fazer login na aplicaçāo.',
        ),
      );
    }
  }
}
