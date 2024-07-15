import 'package:flutter/material.dart';

import '../../../core/theme/mh_colors.dart';
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

  @override
  void initState() {
    super.initState();
    mediaContent = [];
  }

  @override
  Widget build(BuildContext context) {
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
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: mediaContent.isNotEmpty
            ? const MediaContentGrid()
            : const MessageComponent(
                animationPath: 'assets/animations/empty_animation.json',
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
}
