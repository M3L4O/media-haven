import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/injection_container.dart';
import '../../../core/theme/mh_colors.dart';
import '../../login/ui/bloc/load_session/load_session_bloc.dart';
import '../../login/ui/bloc/load_session/load_session_state.dart';
import '../../login/ui/bloc/logout/logout_bloc.dart';
import '../../login/ui/bloc/logout/logout_state.dart';
import '../../login/ui/login_page.dart';
import 'widgets/custom_drawer.dart';
import 'widgets/media_content_grid.dart';
import 'widgets/message_component.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late List mediaContent;
  late ILoadSessionBloc loadSessionBloc;
  late ILogoutBloc logoutBloc;

  @override
  void initState() {
    loadSessionBloc = sl.get<ILoadSessionBloc>();
    loadSessionBloc.loadSession();
    logoutBloc = sl.get<ILogoutBloc>();
    super.initState();
    mediaContent = [];
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener(
          bloc: logoutBloc,
          listener: (context, state) {
            if (state is LogoutSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            }
          },
        ),
      ],
      child: BlocBuilder(
        bloc: logoutBloc,
        builder: (context, logoutState) {
          if (logoutState is LogoutLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return BlocBuilder(
            bloc: loadSessionBloc,
            builder: (context, state) {
              if (state is LoadSessionLoading) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is LoadSessionSuccess) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text(
                      'Dashboard',
                    ),
                    centerTitle: true,
                    toolbarHeight: MediaQuery.of(context).size.height * 0.1,
                    leading: Builder(
                      builder: (BuildContext context) {
                        return IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: const Icon(Icons.menu),
                          tooltip: 'Abrir Menu',
                        );
                      },
                    ),
                  ),
                  drawer: CustomDrawer(
                    username: state.user.username ?? '',
                    onTapLogout: () {
                      logoutBloc.logout();
                    },
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: mediaContent.isNotEmpty
                        ? const MediaContentGrid()
                        : const MessageComponent(
                            animationPath:
                                'assets/animations/empty_animation.json',
                            message: 'Nenhuma mídia encontrada',
                          ),
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      // TODO: Adicionar mídias
                    },
                    tooltip: 'Adicionar Mídias',
                    child: const Icon(
                      Icons.add,
                      color: MHColors.white,
                    ),
                  ),
                );
              }

              return Scaffold(
                body: MessageComponent(
                  animationPath: 'assets/animations/error_animation.json',
                  message:
                      'Erro ao carregar a página :(\nTente fazer login novamente.',
                  size: 150,
                  onTap: () async {
                    final prefs = sl.get<SharedPreferences>();
                    await prefs.clear();
                    if (context.mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
