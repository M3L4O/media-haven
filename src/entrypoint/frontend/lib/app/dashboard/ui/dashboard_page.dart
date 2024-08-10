import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/custom_size.dart';
import '../../../core/injection_container.dart';
import '../../../core/theme/mh_colors.dart';
import '../../login/ui/bloc/logout/logout_bloc.dart';
import '../../login/ui/bloc/logout/logout_state.dart';
import '../../login/ui/login_page.dart';
import '../data/models/file_base.dart';
import 'bloc/upload_image/file_manager_bloc.dart';
import 'bloc/upload_image/file_manager_state.dart';
import 'widgets/custom_drawer.dart';
import 'widgets/media_content.dart';
import 'widgets/message_component.dart';

const List<Widget> icons = <Widget>[
  Icon(
    Icons.grid_3x3,
    size: 18,
  ),
  Icon(
    Icons.menu,
    size: 18,
  ),
];

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late ILogoutBloc logoutBloc;
  late IFileManagerBloc fileManagerBloc;
  final List<bool> _selectedLayout = <bool>[true, false];
  final fileListNotifier = ValueNotifier<List<FileBase>>([]);

  @override
  void initState() {
    logoutBloc = sl.get<ILogoutBloc>();
    fileManagerBloc = sl.get<IFileManagerBloc>();
    fileManagerBloc.getFiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener(
          bloc: fileManagerBloc,
          listener: (context, state) {
            if (state is FileManagerSuccess) {
              if (state.files != null) {
                fileListNotifier.value = state.files!;
              } else if (state.result != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.result ?? ''),
                  ),
                );
              }
            } else if (state is FileManagerFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
        ),
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
              actions: [
                SizedBox(
                  height: 32,
                  child: ToggleButtons(
                    direction: Axis.horizontal,
                    onPressed: (int index) {
                      setState(() {
                        for (int i = 0; i < _selectedLayout.length; i++) {
                          _selectedLayout[i] = i == index;
                        }
                      });
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    borderColor: MHColors.lightGrayVariant,
                    selectedBorderColor: MHColors.blue,
                    selectedColor: MHColors.white,
                    fillColor: MHColors.blue,
                    color: MHColors.blue,
                    isSelected: _selectedLayout,
                    children: icons,
                  ),
                ),
                12.w,
              ],
            ),
            drawer: CustomDrawer(
              username: '',
              onTapLogout: () {
                logoutBloc.logout();
              },
            ),
            body: BlocBuilder(
              bloc: fileManagerBloc,
              builder: (context, state) {
                if (state is FileManagerSuccess) {
                  final files = state.files;

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: files != null && files.isNotEmpty
                        ? ValueListenableBuilder(
                            valueListenable: fileListNotifier,
                            builder: (context, files, _) {
                              return MediaContent(
                                files: files,
                                isGrid: _selectedLayout[0],
                                onSearchChanged: (value) {
                                  fileManagerBloc.searchFiles(text: value);
                                },
                              );
                            },
                          )
                        : const MessageComponent(
                            animationPath:
                                'assets/animations/empty_animation.json',
                            message: 'Nenhuma mídia encontrada',
                          ),
                  );
                }

                return const MessageComponent(
                  animationPath: 'assets/animations/empty_animation.json',
                  message: 'Nenhuma mídia encontrada',
                );
              },
            ),
            floatingActionButton: BlocBuilder(
              bloc: fileManagerBloc,
              builder: (context, state) {
                return FloatingActionButton(
                  onPressed: () {
                    fileManagerBloc.uploadFile();
                  },
                  tooltip: 'Adicionar Mídias',
                  child: const Icon(
                    Icons.add,
                    color: MHColors.white,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
