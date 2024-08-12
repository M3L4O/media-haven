import 'dart:developer';

import 'package:http/http.dart';

import '../../../../core/service/http_client.dart';
import '../models/params/user_login_params.dart';

abstract class ILoginDatasource {
  Future<Response> login({required UserLoginParams user});
}

class LoginDatasource implements ILoginDatasource {
  final IHttpClient http;

  LoginDatasource({required this.http});

  @override
  Future<Response> login({required UserLoginParams user}) async {
    try {
      final result = await http.post(
        'auth/login/',
        user.toJson(),
      );

      log(result.body);

      if (result.statusCode == 200) {
        return result;
      }

      throw Exception();
    } catch (e) {
      rethrow;
    }
  }
}
