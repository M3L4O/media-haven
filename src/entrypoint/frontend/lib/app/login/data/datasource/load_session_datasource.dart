import 'package:http/http.dart';

import '../../../../core/service/http_client.dart';
import '../models/params/user_token_params.dart';

abstract class ILoadSessionDatasource {
  Future<Response> loadSession({
    required UserTokenParams user,
  });
}

class LoadSessionDatasource implements ILoadSessionDatasource {
  final IHttpClient http;

  LoadSessionDatasource({
    required this.http,
  });

  @override
  Future<Response> loadSession({required UserTokenParams user}) async {
    try {
      final result = await http.post(
        '/load_session/',
        user.toJson(),
      );

      return result;
    } catch (e) {
      rethrow;
    }
  }
}
