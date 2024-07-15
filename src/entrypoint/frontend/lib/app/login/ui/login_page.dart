// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:frontend/app/login/ui/widgets/form_options.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  final formKey = GlobalKey<FormState>();

  bool loginMode = true;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/login_bg.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      key: formKey,
                      child: FormOptions(
                        loginMode: loginMode,
                        emailController: _emailController,
                        passwordController: _passwordController,
                        nameController: _nameController,
                        confirmPasswordController: _confirmPasswordController,
                        onChangeLogin: () {
                          setState(() {
                            loginMode = true;
                          });
                          _clearForm();
                        },
                        onChangeRegister: () {
                          setState(() {
                            loginMode = false;
                          });
                          _clearForm();
                        },
                        onTapLogin: () {
                          final isValidate = formKey.currentState!.validate();
                          if (isValidate) {
                            _clearForm();
                            Navigator.pushReplacementNamed(
                              context,
                              '/dashboard',
                            );
                          }
                        },
                        onTapRegister: () {
                          final isValidate = formKey.currentState!.validate();
                          if (isValidate) {
                            _clearForm();
                            Navigator.pushReplacementNamed(
                              context,
                              '/dashboard',
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _clearForm() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    formKey.currentState?.reset();
  }
}
