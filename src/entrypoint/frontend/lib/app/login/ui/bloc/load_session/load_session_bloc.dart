import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/params/user_token_params.dart';
import '../../../data/repository/load_session_repository.dart';
import 'load_session_state.dart';

abstract class ILoadSessionBloc extends Cubit<LoadSessionState> {
  ILoadSessionBloc() : super(LoadSessionInitial());

  Future<void> loadSession();
}

class LoadSessionBloc extends ILoadSessionBloc {
  final ILoadSessionRepository repository;
  final SharedPreferences sharedPreferences;

  LoadSessionBloc({
    required this.repository,
    required this.sharedPreferences,
  });

  @override
  Future<void> loadSession() async {
    emit(LoadSessionLoading());
    try {
      final token = sharedPreferences.getString('token');

      final user = UserTokenParams(
        token: token,
      );

      final result = await repository.loadSession(
        user: user,
      );

      emit(LoadSessionSuccess(user: result));
    } catch (e) {
      emit(LoadSessionFailure(
        message: 'Ocorreu um erro ao carregar dados da pessoa usuária.',
      ));
    }
  }
}
