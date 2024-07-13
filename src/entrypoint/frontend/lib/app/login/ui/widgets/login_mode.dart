import 'package:flutter/material.dart';

import '../../../../core/helpers/custom_size.dart';
import 'custom_button.dart';
import 'custom_text_form_field.dart';
import '../../../dashboard/ui/dashboard_page.dart';

class LoginMode extends StatelessWidget {
  const LoginMode({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
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
            CustomButton(
              text: 'Login',
              onTap: () {
                // TODO: add funcionality
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Dashboard(),
                  ),
                );
              },
            ),
          ],
        )
      ],
    );
  }
}
