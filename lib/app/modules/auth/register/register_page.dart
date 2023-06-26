import 'package:app_cuida_pet/app/core/ui/extensions/size_screen_extension.dart';
import 'package:app_cuida_pet/app/modules/auth/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/cuidapet_buttom_default.dart';
import '../../../core/ui/widgets/cuidapet_txtform.dart';
part './widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Usuário'),
        elevation: 0,
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
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
              _RegisterForm()
            ],
          ),
        ),
      ),
    );
  }
}
