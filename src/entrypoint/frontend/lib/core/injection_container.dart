import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/dashboard/data/datasource/file_manager_datasource.dart';
import '../app/dashboard/data/repository/file_manager_repository.dart';
import '../app/dashboard/ui/bloc/player_audio/audio_player_bloc.dart';
import '../app/dashboard/ui/bloc/upload_image/file_manager_bloc.dart';
import '../app/login/data/datasource/login_datasource.dart';
import '../app/login/data/datasource/logout_datasource.dart';
import '../app/login/data/datasource/register_datasource.dart';
import '../app/login/data/repository/login_repository.dart';
import '../app/login/data/repository/logout_repository.dart';
import '../app/login/data/repository/register_repository.dart';
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
        loginRepository: sl<ILoginRepository>(),
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
    ..registerSingleton<IFileManagerDatasource>(
      FileManagerDatasource(
        http: sl<IHttpClient>(),
      ),
    )
    ..registerSingleton<IFileManagerRepository>(
      FileManagerRepository(
        datasource: sl<IFileManagerDatasource>(),
      ),
    )
    ..registerSingleton<IFileManagerBloc>(
      FileManagerBloc(
        repository: sl<IFileManagerRepository>(),
        sharedPreferences: sl<SharedPreferences>(),
      ),
    )
    ..registerSingleton<IAudioPlayerBloc>(
      AudioPlayerBloc(),
    );
}
