part of '../login_page.dart';

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CuidapetTxtform(labelText: 'Login'),
          const SizedBox(
            height: 20,
          ),
          CuidapetTxtform(
            labelText: 'Senha',
            obscureText: true,
          ),
          const SizedBox(
            height: 20,
          ),
          CuidapetButtomDefault(
            label: 'Entrar',
            onPressed: () {
              Loader.show();
              
              Future.delayed(Duration(seconds: 2), () {
                Loader.hide();
              });
            },
          )
        ],
      ),
    );
  }
}
