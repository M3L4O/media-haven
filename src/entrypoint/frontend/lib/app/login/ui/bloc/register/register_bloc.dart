import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/params/user_register_params.dart';
import '../../../data/repository/register_repository.dart';
import 'register_state.dart';

abstract class IRegisterBloc extends Cubit<RegisterState> {
  IRegisterBloc() : super(RegisterInitial());

  Future<void> register({
    required String email,
    required String password,
  });
}

class RegisterBloc extends IRegisterBloc {
  final IRegisterRepository repository;

  RegisterBloc({required this.repository});

  @override
  Future<void> register({
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());
    try {
      final user = UserRegisterParams(
        name: password,
        email: email,
        password: password,
      );

      final result = await repository.register(user: user);

      emit(RegisterSuccess(user: result));
    } catch (e) {
      emit(RegisterFailure(message: e.toString()));
    }
  }
}
