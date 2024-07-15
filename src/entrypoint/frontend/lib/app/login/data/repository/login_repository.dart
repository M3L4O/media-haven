import 'dart:convert';

import '../datasource/login_datasource.dart';
import '../models/params/user_login_params.dart';
import '../models/token_model.dart';

abstract class ILoginRepository {
  Future<TokenModel> login({required UserLoginParams user});
}

class LoginRepository implements ILoginRepository {
  final ILoginDatasource datasource;

  LoginRepository({required this.datasource});

  @override
  Future<TokenModel> login({required UserLoginParams user}) async {
    try {
      final result = await datasource.login(
        user: user,
      );

      final data = jsonDecode(result.body);

      return TokenModel.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
}
