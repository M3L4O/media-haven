import 'package:flutter/material.dart';

import '../../../../core/helpers/custom_size.dart';
import '../../../../core/theme/mh_colors.dart';
import 'login_mode.dart';
import 'register_mode.dart';

class FormOptions extends StatefulWidget {
  const FormOptions({
    super.key,
    required this.onTapLogin,
    required this.onTapRegister,
    required this.loginMode,
    required this.emailController,
    required this.passwordController,
    required this.nameController,
    required this.confirmPasswordController,
  });

  final bool loginMode;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController confirmPasswordController;

  final Function() onTapLogin;
  final Function() onTapRegister;

  @override
  State<FormOptions> createState() => _FormOptionsState();
}

class _FormOptionsState extends State<FormOptions> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 24),
        width: 600,
        child: Column(
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 200,
            ),
            64.h,
            Container(
              width: 200,
              height: 40,
              decoration: BoxDecoration(
                color: MHColors.lightGray,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: widget.onTapLogin,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 100,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: widget.loginMode
                            ? MHColors.blue
                            : MHColors.lightGray,
                        borderRadius: defineBorderRadius(index: 0),
                      ),
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: widget.loginMode
                                ? MHColors.white
                                : MHColors.darkGray,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: widget.onTapRegister,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 100,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: !widget.loginMode
                            ? MHColors.blue
                            : MHColors.lightGray,
                        borderRadius: defineBorderRadius(index: 1),
                      ),
                      child: Center(
                        child: Text(
                          'Cadastre-se',
                          style: TextStyle(
                            color: !widget.loginMode
                                ? MHColors.white
                                : MHColors.darkGray,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SizeTransition(sizeFactor: animation, child: child);
              },
              child: widget.loginMode
                  ? LoginMode(
                      emailController: widget.emailController,
                      passwordController: widget.passwordController,
                    )
                  : RegisterMode(
                      nameController: widget.nameController,
                      emailController: widget.emailController,
                      passwordController: widget.passwordController,
                      confirmPasswordController:
                          widget.confirmPasswordController,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  BorderRadius defineBorderRadius({required int index}) {
    return BorderRadius.circular(20);
  }
}
