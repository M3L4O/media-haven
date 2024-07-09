// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:frontend/app/login/ui/widgets/form_options.dart';
import 'package:frontend/app/login/ui/widgets/information.dart';

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

  final List<bool> _formMode = [true, false];

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
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Flexible(
                    child: Information(
                      logoUrl: 'assets/images/logo.png',
                      title: 'Bem vindo',
                      description:
                          'Media Heaven é a solução definitiva para organizar, reproduzir e desfrutar de sua biblioteca de mídia em um só lugar. Com uma interface intuitiva e recursos poderosos, este gerenciador multimídia oferece uma experiência sem igual.',
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: FormOptions(
                      formMode: _formMode,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      nameController: _nameController,
                      confirmPasswordController: _confirmPasswordController,
                      onTapLogin: () {
                        setState(() {
                          _formMode[0] = true;
                          _formMode[1] = false;
                        });
                      },
                      onTapRegister: () {
                        setState(() {
                          _formMode[0] = false;
                          _formMode[1] = true;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
