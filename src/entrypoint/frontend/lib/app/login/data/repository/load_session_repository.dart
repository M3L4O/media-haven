import 'dart:convert';

import '../datasource/load_session_datasource.dart';
import '../models/params/user_token_params.dart';
import '../models/token_model.dart';

abstract class ILoadSessionRepository {
  Future<TokenModel> loadSession({
    required UserTokenParams user,
  });
}

class LoadSessionRepository implements ILoadSessionRepository {
  final ILoadSessionDatasource datasource;

  LoadSessionRepository({required this.datasource});

  @override
  Future<TokenModel> loadSession({required UserTokenParams user}) async {
    try {
      final result = await datasource.loadSession(
        user: user,
      );

      final data = jsonDecode(result.body);

      return TokenModel.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
}
