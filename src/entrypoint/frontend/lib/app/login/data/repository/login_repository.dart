import 'dart:convert';

import '../datasource/login_datasource.dart';
import '../models/params/user_login_params.dart';
import '../models/user_model.dart';

abstract class ILoginRepository {
  Future<User> login({required UserLoginParams user});
}

class LoginRepository implements ILoginRepository {
  final ILoginDatasource datasource;

  LoginRepository({required this.datasource});

  @override
  Future<User> login({required UserLoginParams user}) async {
    try {
      final result = await datasource.login(
        user: user,
      );

      final data = jsonDecode(result.body);

      return User.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
}
