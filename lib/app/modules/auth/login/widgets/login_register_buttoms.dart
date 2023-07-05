part of '../login_page.dart';

class _LoginRegisterButtoms extends StatelessWidget {
  final controller = Modular.get<LoginController>();

  _LoginRegisterButtoms();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: [
        RoundedButtomIcon(
            onPressed: () {
              Messages.info('DESABILITADO');
              //controller.socialLogin(SocialLoginType.facebook);
            },
            width: .42.sw,
            color: Colors.blue,
            icon: CuidapetIcons.facebook,
            label: 'Facebook'),
        RoundedButtomIcon(
            onPressed: () {
              controller.socialLogin(SocialLoginType.google);
              
            },
            width: .42.sw,
            color: Colors.red[300],
            icon: CuidapetIcons.google,
            label: 'Google'),
        RoundedButtomIcon(
            onPressed: () {
              Navigator.pushNamed(context, '/auth/register');
            },
            width: .42.sw,
            color: Colors.grey,
            icon: Icons.mail,
            label: 'Cadastre-se'),
      ],
    );
  }
}
