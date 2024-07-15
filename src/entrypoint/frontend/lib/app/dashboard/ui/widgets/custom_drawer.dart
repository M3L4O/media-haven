import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/mh_colors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.username,
    required this.onTapLogout,
  });

  final String username;
  final Function() onTapLogout;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            color: MHColors.blue,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: '',
                    height: 50,
                    width: 50,
                    placeholder: (context, url) {
                      return const SizedBox(
                        height: 20,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Container(
                        decoration: const BoxDecoration(
                          color: MHColors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.person,
                            color: MHColors.blue,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  Text(
                    username,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
            onTap: () {
              // TODO: Handle Configurações action
            },
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sair'),
            onTap: onTapLogout,
          ),
        ],
      ),
    );
  }
}
