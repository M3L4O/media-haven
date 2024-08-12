import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/params/user_token_params.dart';
import '../../../data/repository/logout_repository.dart';
import 'logout_state.dart';

abstract class ILogoutBloc extends Cubit<LogoutState> {
  ILogoutBloc() : super(LogoutInitial());

  Future<void> logout();
}

class LogoutBloc extends ILogoutBloc {
  final ILogoutRepository repository;
  final SharedPreferences sharedPreferences;

  LogoutBloc({
    required this.repository,
    required this.sharedPreferences,
  });

  @override
  Future<void> logout() async {
    emit(LogoutLoading());
    try {
      final token = sharedPreferences.getString('token');

      final user = UserTokenParams(
        token: token,
      );

      final result = await repository.logout(user: user);

      await sharedPreferences.clear();

      emit(LogoutSuccess(status: result));
    } catch (e) {
      emit(
        LogoutFailure(message: 'Ocorreu um erro ao tentar sair da aplicaçāo.'),
      );
    }
  }
}
