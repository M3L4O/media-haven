import 'package:http/http.dart';

import '../../../../core/service/http_client.dart';
import '../models/params/user_token_params.dart';

abstract class ILogoutDatasource {
  Future<Response> logout({required UserTokenParams user});
}

class LogoutDatasource extends ILogoutDatasource {
  final IHttpClient http;

  LogoutDatasource({required this.http});

  @override
  Future<Response> logout({required UserTokenParams user}) async {
    try {
      final result = await http.post(
        '/logout/',
        user.toJson(),
      );

      return result;
    } catch (e) {
      rethrow;
    }
  }
}
