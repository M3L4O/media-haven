import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/params/user_login_params.dart';
import '../../../data/models/params/user_register_params.dart';
import '../../../data/repository/login_repository.dart';
import '../../../data/repository/register_repository.dart';
import 'register_state.dart';

abstract class IRegisterBloc extends Cubit<RegisterState> {
  IRegisterBloc() : super(RegisterInitial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
  });
}

class RegisterBloc extends IRegisterBloc {
  final IRegisterRepository repository;
  final ILoginRepository loginRepository;
  final SharedPreferences sharedPreferences;

  RegisterBloc({
    required this.repository,
    required this.loginRepository,
    required this.sharedPreferences,
  });

  @override
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());
    try {
      final user = UserRegisterParams(
        name: name,
        email: email,
        password: password,
      );

      final result = await repository.register(user: user);
      final token = await loginRepository.login(
        user: UserLoginParams(
          email: email,
          password: password,
        ),
      );

      final access = token.access;
      await sharedPreferences.setString('email', email);
      if (access != null) await sharedPreferences.setString('token', access);

      emit(RegisterSuccess(user: result));
    } catch (e) {
      emit(
        RegisterFailure(
            message: 'Ocorreu um erro ao tentar registrar-se na aplicaçāo.'),
      );
    }
  }
}
