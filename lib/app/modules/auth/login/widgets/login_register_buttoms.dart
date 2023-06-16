part of '../login_page.dart';

class _LoginRegisterButtoms extends StatelessWidget {
  const _LoginRegisterButtoms({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: [
        RoundedButtomIcon(
            onPressed: () {},
            width: .42.sw,
            color: Colors.blue,
            icon: CuidapetIcons.facebook,
            label: 'Facebook'),
        RoundedButtomIcon(
            onPressed: () {},
            width: .42.sw,
            color: Colors.red[300],
            icon: CuidapetIcons.google,
            label: 'Google'),
        RoundedButtomIcon(
            onPressed: () {},
            width: .42.sw,
            color: Colors.grey,
            icon: Icons.mail,
            label: 'Cadastre-se'),
      ],
    );
  }
}
