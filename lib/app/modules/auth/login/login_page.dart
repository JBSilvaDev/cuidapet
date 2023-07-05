import 'package:app_cuida_pet/app/core/ui/extensions/size_screen_extension.dart';
import 'package:app_cuida_pet/app/core/ui/extensions/theme_extensions.dart';
import 'package:app_cuida_pet/app/modules/auth/login/widgets/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';
import '../../../core/ui/cuidapet_buttom_default.dart';
import '../../../core/ui/icons/cuidapet_icons.dart';
import '../../../core/ui/rounded_buttom_icon.dart';
import '../../../core/ui/widgets/cuidapet_txtform.dart';
import '../../../core/ui/widgets/loader.dart';
import '../../../core/ui/widgets/messages.dart';
import '../../../models/social_login_type.dart';

part './widgets/login_form.dart';
part './widgets/login_register_buttoms.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 162,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const _LoginForm(),
            const SizedBox(
              height: 20,
            ),
            const _OrSeparetor(),
            const SizedBox(
              height: 20,
            ),
             _LoginRegisterButtoms()
          ],
        ),
      ),
    ));
  }
}

class _OrSeparetor extends StatelessWidget {
  const _OrSeparetor();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 1,
            color: context.primaryColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'OU',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              color: context.primaryColor,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 1,
            color: context.primaryColor,
          ),
        ),
      ],
    );
  }
}
