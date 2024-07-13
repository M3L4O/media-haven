import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/helpers/custom_size.dart';
import '../../../../core/helpers/validators.dart';
import 'custom_button.dart';
import 'custom_text_form_field.dart';

class LoginMode extends StatefulWidget {
  const LoginMode({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onLogin,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function() onLogin;

  @override
  State<LoginMode> createState() => _LoginModeState();
}

class _LoginModeState extends State<LoginMode> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        32.h,
        CustomTextFormField(
          labelText: 'Email',
          hintText: 'Digite seu email',
          icon: Icons.email,
          onChanged: (value) {
            // TODO: add funcionality
          },
          controller: widget.emailController,
          validator: validateEmail,
          keyboardType: TextInputType.emailAddress,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp("[0-9@a-zA-Z.]")),
          ],
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
          controller: widget.passwordController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Campo de senha obrigatório';
            }
            return null;
          },
        ),
        32.h,
        CustomButton(
          text: 'Login',
          onTap: widget.onLogin,
        ),
      ],
    );
  }
}
