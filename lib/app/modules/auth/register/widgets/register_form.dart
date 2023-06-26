part of '../register_page.dart';

class _RegisterForm extends StatefulWidget {
  const _RegisterForm({super.key});

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _loginEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final controller = Modular.get<RegisterController>();

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
                Validatorless.required('Login obrigatorio!'),
                Validatorless.email('Login deve ser um e-mail valido')
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
                Validatorless.required('Senha Obrigatoria'),
                Validatorless.min(
                    6, 'Senha precisa ter pelo menos 6 catacteres')
              ]),
            ),
            const SizedBox(
              height: 20,
            ),
            CuidapetTxtform(
              labelText: 'Confirma Senha',
              obscureText: true,
              validator: Validatorless.multiple([
                Validatorless.required('Confirmar senha obrigatorio'),
                Validatorless.min(
                    6, 'Senha precisa ter pelo menos 6 catacteres'),
                Validatorless.compare(_passwordEC, 'As Senhas nao são iguais')
              ]),
            ),
            const SizedBox(
              height: 20,
            ),
            CuidapetButtomDefault(
              label: 'Cadastrar',
              onPressed: () {
                final formValid = _formKey.currentState?.validate() ?? false;

                if (formValid) {
                  controller.register(
                      email: _loginEC.text, password: _passwordEC.text);
                }
              },
            )
          ],
        ));
  }
}
