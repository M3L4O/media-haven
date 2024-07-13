import '../app/login/data/datasource/register_datasource.dart';
import '../app/login/data/repository/login_repository.dart';
import '../app/login/data/repository/register_repository.dart';
import '../app/login/ui/bloc/login/login_bloc.dart';
import '../app/login/ui/bloc/register/register_bloc.dart';

import '../app/login/data/datasource/login_datasource.dart';
import 'package:get_it/get_it.dart';

import 'service/http_client.dart';

final sl = GetIt.instance;

void initGlobalContainer() {
  sl
    ..registerSingleton<IHttpClient>(
      HttpClient(),
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
      ),
    )
    ..registerSingleton<IRegisterDatasource>(
      RegisterDatasource(
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
      ),
    );
}
