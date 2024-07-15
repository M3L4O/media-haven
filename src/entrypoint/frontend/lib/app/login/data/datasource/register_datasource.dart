import 'package:http/http.dart';

import '../../../../core/service/http_client.dart';
import '../models/params/user_register_params.dart';

abstract class IRegisterDatasource {
  Future<Response> register({required UserRegisterParams user});
}

class RegisterDatasource implements IRegisterDatasource {
  final IHttpClient http;

  RegisterDatasource({required this.http});

  @override
  Future<Response> register({required UserRegisterParams user}) async {
    try {
      final result = await http.post(
        '/sign_up/',
        user.toJson(),
      );

      return result;
    } catch (e) {
      rethrow;
    }
  }
}
