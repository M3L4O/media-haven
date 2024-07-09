
import 'package:flutter/material.dart';
import 'package:frontend/app/login/ui/widgets/custom_elevated_button.dart';
import 'package:frontend/app/login/ui/widgets/custom_text_form_field.dart';
import 'package:frontend/core/helpers/custom_size.dart';

class RegisterMode extends StatelessWidget {
  const RegisterMode({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
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
            ),
            32.h,
            CustomElevatedButton(
              text: 'Cadastre-se',
              onPressed: () {
                // TODO: add funcionality
              },
            ),
          ],
        )
      ],
    );
  }
}