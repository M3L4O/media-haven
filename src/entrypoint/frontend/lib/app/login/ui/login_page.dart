import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/injection_container.dart';
import '../../dashboard/ui/dashboard_page.dart';
import 'bloc/login/login_bloc.dart';
import 'bloc/login/login_state.dart';
import 'bloc/register/register_bloc.dart';
import 'bloc/register/register_state.dart';
import 'widgets/form_options.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late ILoginBloc loginBloc;
  late IRegisterBloc registerBloc;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  final formKey = GlobalKey<FormState>();

  bool loginMode = true;

  @override
  void initState() {
    loginBloc = sl.get<ILoginBloc>();
    registerBloc = sl.get<IRegisterBloc>();

    _emailController = TextEditingController(text: 'melo@gmail.com');
    _passwordController = TextEditingController(text: 'melo');
    _nameController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Container(
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
                  MultiBlocListener(
                    listeners: [
                      BlocListener<ILoginBloc, LoginState>(
                        bloc: loginBloc,
                        listener: (context, state) {
                          if (state is LoginFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                              ),
                            );
                          } else if (state is LoginSuccess) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Dashboard(),
                              ),
                            );
                          }
                        },
                      ),
                      BlocListener<IRegisterBloc, RegisterState>(
                        bloc: registerBloc,
                        listener: (context, state) {
                          if (state is RegisterFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                              ),
                            );
                          } else if (state is RegisterSuccess) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Dashboard(),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                    child: BlocBuilder(
                      bloc: registerBloc,
                      builder: (context, state) {
                        if (state is RegisterLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return BlocBuilder<ILoginBloc, LoginState>(
                          bloc: loginBloc,
                          builder: (context, state) {
                            if (state is LoginLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return Form(
                              key: formKey,
                              child: FormOptions(
                                loginMode: loginMode,
                                emailController: _emailController,
                                passwordController: _passwordController,
                                nameController: _nameController,
                                confirmPasswordController:
                                    _confirmPasswordController,
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
                                onTapLogin: () async {
                                  final isValidate =
                                      formKey.currentState!.validate();
                                  if (isValidate) {
                                    await loginBloc.login(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );
                                    _clearForm();
                                  }
                                },
                                onTapRegister: () async {
                                  final isValidate =
                                      formKey.currentState!.validate();
                                  if (isValidate) {
                                    await registerBloc.register(
                                      name: _nameController.text,
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );
                                    _clearForm();
                                  }
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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
