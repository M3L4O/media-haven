import 'dart:convert';

import '../datasource/register_datasource.dart';
import '../models/params/user_register_params.dart';
import '../models/token_model.dart';

abstract class IRegisterRepository {
  Future<TokenModel> register({required UserRegisterParams user});
}

class RegisterRepository implements IRegisterRepository {
  final IRegisterDatasource datasource;

  RegisterRepository({required this.datasource});

  @override
  Future<TokenModel> register({required UserRegisterParams user}) async {
    try {
      final result = await datasource.register(
        user: user,
      );

      final data = jsonDecode(result.body);

      return TokenModel.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
}
