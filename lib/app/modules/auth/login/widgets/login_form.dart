part of '../login_page.dart';

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _loginEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final controller = Modular.get<LoginController>();

  @override
  void dispose() {
    _loginEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CuidapetTxtform(
            labelText: 'Login',
            controllerEC: _loginEC,
            validator: Validatorless.multiple([
              Validatorless.required('Login obrigatorio'),
              Validatorless.email('E-mail invalido')
            ]),
          ),
          const SizedBox(
            height: 20,
          ),
          CuidapetTxtform(
              labelText: 'Senha',
              obscureText: true,
              controllerEC: _passwordEC,
              validator: Validatorless.multiple([
                Validatorless.required('Senha obrigatoria'),
                Validatorless.min(
                    6, 'Senha deve conter pelo menos 6 caracteres'),
              ])),
          const SizedBox(
            height: 20,
          ),
          CuidapetButtomDefault(
            label: 'Entrar',
            onPressed: () async {
              final formValid = _formKey.currentState?.validate() ?? false;
              if(formValid){
              Loader.show();
              await controller.login(_loginEC.text, _passwordEC.text);


              }
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
