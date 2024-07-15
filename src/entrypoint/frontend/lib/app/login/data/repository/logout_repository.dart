import '../datasource/logout_datasource.dart';
import '../models/params/user_token_params.dart';

abstract class ILogoutRepository {
  Future<bool> logout({required UserTokenParams user});
}

class LogoutRepository implements ILogoutRepository {
  final ILogoutDatasource datasource;

  LogoutRepository({required this.datasource});

  @override
  Future<bool> logout({required UserTokenParams user}) async {
    try {
      final result = await datasource.logout(
        user: user,
      );

      return result.statusCode == 200;
    } catch (e) {
      rethrow;
    }
  }
}
