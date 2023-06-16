part of '../register_page.dart';

class _RegisterForm extends StatefulWidget {
  const _RegisterForm({super.key});

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
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
        CuidapetTxtform(
          labelText: 'Confirma Senha',
          obscureText: true,
        ),
        const SizedBox(
          height: 20,
        ),
        CuidapetButtomDefault(
          label: 'Cadastrar',

          onPressed: () {},
        )
      ],
    ));
  }
}
