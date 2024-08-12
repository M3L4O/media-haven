import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/params/user_register_params.dart';
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
  final SharedPreferences sharedPreferences;

  RegisterBloc({
    required this.repository,
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

      final nameResult = result.username;
      final token = result.access;

      if (nameResult != null && token != null) {
        await sharedPreferences.setString('token', token);
        await sharedPreferences.setString('name', nameResult);
      }

      emit(RegisterSuccess(user: result));
    } catch (e) {
      emit(RegisterFailure(message: 'Ocorreu um erro ao tentar registrar-se na aplicaçāo.'));
    }
  }
}
