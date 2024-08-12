import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/mh_colors.dart';
import '../../../login/ui/widgets/custom_text_form_field.dart';

void _showEditProfileDialog(
  BuildContext context,
  String username,
  String email,
) {
  final nameController = TextEditingController(text: username);
  final emailController = TextEditingController(text: email);
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Editar perfil'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  // TODO: lógica para adicionar/alterar a foto de perfil
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[300],
                      child: CachedNetworkImage(
                        imageUrl: '',
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          radius: 40,
                          backgroundImage: imageProvider,
                        ),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.white),
                      ),
                    ),
                    const Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: MHColors.blue,
                        radius: 15,
                        child: Icon(
                          Icons.edit,
                          size: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                labelText: 'Nome de usuário',
                hintText: 'Digite o novo nome de usuário',
                icon: Icons.person,
                onChanged: (value) {},
                controller: nameController,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                labelText: 'E-mail',
                hintText: 'E-mail',
                icon: Icons.email,
                onChanged: (value) {},
                controller: emailController,
                enabled: false,
                backgroundColor: Colors.grey[300],
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                labelText: 'Senha antiga',
                hintText: '',
                icon: Icons.lock_outline,
                onChanged: (value) {},
                controller: oldPasswordController,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                labelText: 'Nova senha',
                hintText: '',
                icon: Icons.lock_outline,
                onChanged: (value) {},
                controller: newPasswordController,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                labelText: 'Confirme a nova senha',
                hintText: '',
                icon: Icons.lock_outline,
                onChanged: (value) {},
                controller: confirmPasswordController,
                obscureText: true,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              foregroundColor: MHColors.blue,
            ),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Lógica para salvar as alterações feitas
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: MHColors.blue,
              foregroundColor: Colors.white,
            ),
            child: const Text('Salvar'),
          ),
        ],
      );
    },
  );
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.email,
    required this.onTapLogout,
  });

  final String email;
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
                    email,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          // ListTile(
          //   leading: const Icon(Icons.edit),
          //   title: const Text('Editar informações do perfil'),
          //   onTap: () {
          //     _showEditProfileDialog(context, email);
          //   },
          // ),
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
