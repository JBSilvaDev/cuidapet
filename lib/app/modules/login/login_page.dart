import 'package:app_cuida_pet/app/core/ui/widgets/cuidapet_txtform.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final testEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CuidapetTxtform(
                controllerEC: testEC,
                labelText: 'Login',
                validator: (value) {
                  // passo o value para string pois ele é dinamico
                  if (value.toString().isEmpty || value == null) {
                    return 'valor obrigadotrio';
                  }
                  return null;
                },
              ),
              Text(testEC.text),
              ElevatedButton(
                onPressed: () {
                  formKey.currentState?.validate();
                  debugPrint(testEC.text);
                },
                child: Text('Validar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
