import 'package:flutter/material.dart';
import 'login_mode.dart';
import 'register_mode.dart';
import '../../../../core/helpers/custom_size.dart';
import '../../../../core/theme/mh_colors.dart';

class FormOptions extends StatelessWidget {
  const FormOptions({
    super.key,
    required this.onTapLogin,
    required this.onTapRegister,
    required this.formMode,
    required this.emailController,
    required this.passwordController,
    required this.nameController,
    required this.confirmPasswordController,
  });

  final List<bool> formMode;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController confirmPasswordController;

  final Function() onTapLogin;
  final Function() onTapRegister;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 24),
        width: MediaQuery.of(context).size.width * 0.4,
        child: Column(
          children: [
            32.h,
            Container(
              width: 200,
              height: 32,
              decoration: BoxDecoration(
                color: MHColors.darkGray,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: onTapLogin,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 100,
                      height: 32,
                      decoration: BoxDecoration(
                        color: defineColor(index: 0),
                        borderRadius: defineBorderRadius(index: 0),
                      ),
                      child: const Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: MHColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onTapRegister,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 100,
                      height: 32,
                      decoration: BoxDecoration(
                        color: defineColor(index: 1),
                        borderRadius: defineBorderRadius(index: 1),
                      ),
                      child: const Center(
                        child: Text(
                          'Cadastre-se',
                          style: TextStyle(
                            color: MHColors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Visibility(
              visible: formMode[0],
              child: LoginMode(
                emailController: emailController,
                passwordController: passwordController,
              ),
            ),
            Visibility(
              visible: formMode[1],
              child: RegisterMode(
                nameController: nameController,
                emailController: emailController,
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color defineColor({required int index}) =>
      formMode[index] ? MHColors.purple : MHColors.darkGray;

  BorderRadius defineBorderRadius({required int index}) {
    return BorderRadius.circular(20);
  }
}
