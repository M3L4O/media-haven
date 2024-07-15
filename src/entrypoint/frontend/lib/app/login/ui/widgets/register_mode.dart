import 'package:flutter/material.dart';

import '../../../../core/helpers/custom_size.dart';
import '../../../../core/helpers/validators.dart';
import 'custom_button.dart';
import 'custom_text_form_field.dart';

class RegisterMode extends StatelessWidget {
  const RegisterMode({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onRegister,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  final Function() onRegister;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        32.h,
        CustomTextFormField(
          labelText: 'Nome',
          hintText: 'Difgite seu nome',
          icon: Icons.text_format_outlined,
          onChanged: (value) {
            // TODO: add funcionality
          },
          controller: nameController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Campo de nome obrigatório';
            }
            return null;
          },
        ),
        32.h,
        CustomTextFormField(
          labelText: 'Email',
          hintText: 'Digite seu email',
          icon: Icons.email,
          onChanged: (value) {
            // TODO: add funcionality
          },
          controller: emailController,
          validator: validateEmail,
        ),
        32.h,
        CustomTextFormField(
          labelText: 'Senha',
          hintText: 'Digite sua senha',
          icon: Icons.password,
          obscureText: true,
          onChanged: (value) {
            // TODO: add funcionality
          },
          controller: passwordController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Campo de senha obrigatório';
            }
            return null;
          },
        ),
        32.h,
        CustomTextFormField(
          labelText: 'Confirmar senha',
          hintText: 'Confirme sua senha',
          icon: Icons.password,
          obscureText: true,
          onChanged: (value) {
            // TODO: add funcionality
          },
          controller: confirmPasswordController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Campo de senha obrigatório';
            } else if (value != passwordController.text) {
              return 'Senhas não conferem';
            }
            return null;
          },
        ),
        32.h,
        CustomButton(
          text: 'Cadastre-se',
          onTap: onRegister,
        ),
      ],
    );
  }
}
