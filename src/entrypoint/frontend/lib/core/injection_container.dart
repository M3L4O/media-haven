import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/login/data/datasource/load_session_datasource.dart';
import '../app/login/data/datasource/login_datasource.dart';
import '../app/login/data/datasource/logout_datasource.dart';
import '../app/login/data/datasource/register_datasource.dart';
import '../app/login/data/repository/load_session_repository.dart';
import '../app/login/data/repository/login_repository.dart';
import '../app/login/data/repository/logout_repository.dart';
import '../app/login/data/repository/register_repository.dart';
import '../app/login/ui/bloc/load_session/load_session_bloc.dart';
import '../app/login/ui/bloc/login/login_bloc.dart';
import '../app/login/ui/bloc/logout/logout_bloc.dart';
import '../app/login/ui/bloc/register/register_bloc.dart';
import 'service/http_client.dart';

final sl = GetIt.instance;

Future<void> initGlobalContainer() async {
  final prefs = await SharedPreferences.getInstance();

  sl
    ..registerSingleton<IHttpClient>(
      HttpClient(),
    )
    ..registerSingleton<SharedPreferences>(
      prefs,
    )
    ..registerSingleton<ILoginDatasource>(
      LoginDatasource(
        http: sl<IHttpClient>(),
      ),
    )
    ..registerSingleton<ILoginRepository>(
      LoginRepository(
        datasource: sl<ILoginDatasource>(),
      ),
    )
    ..registerSingleton<ILoginBloc>(
      LoginBloc(
        repository: sl<ILoginRepository>(),
        sharedPreferences: sl<SharedPreferences>(),
      ),
    )
    ..registerLazySingleton<IRegisterDatasource>(
      () => RegisterDatasource(
        http: sl<IHttpClient>(),
      ),
    )
    ..registerSingleton<IRegisterRepository>(
      RegisterRepository(
        datasource: sl<IRegisterDatasource>(),
      ),
    )
    ..registerSingleton<IRegisterBloc>(
      RegisterBloc(
        repository: sl<IRegisterRepository>(),
        sharedPreferences: sl<SharedPreferences>(),
      ),
    )
    ..registerSingleton<ILogoutDatasource>(
      LogoutDatasource(
        http: sl<IHttpClient>(),
      ),
    )
    ..registerSingleton<ILogoutRepository>(
      LogoutRepository(
        datasource: sl<ILogoutDatasource>(),
      ),
    )
    ..registerSingleton<ILogoutBloc>(
      LogoutBloc(
        repository: sl<ILogoutRepository>(),
        sharedPreferences: sl<SharedPreferences>(),
      ),
    )
    ..registerSingleton<ILoadSessionDatasource>(
      LoadSessionDatasource(
        http: sl<IHttpClient>(),
      ),
    )
    ..registerSingleton<ILoadSessionRepository>(
      LoadSessionRepository(
        datasource: sl<ILoadSessionDatasource>(),
      ),
    )
    ..registerSingleton<ILoadSessionBloc>(
      LoadSessionBloc(
        repository: sl<ILoadSessionRepository>(),
        sharedPreferences: sl<SharedPreferences>(),
      ),
    );
}
