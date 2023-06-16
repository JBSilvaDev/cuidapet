import 'package:app_cuida_pet/app/modules/auth/register/register_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterModule extends Module {

   @override
   List<Bind> get binds => [];

   @override
   List<ModularRoute> get routes => [
      ChildRoute(Modular.initialRoute, child: (context, args) => RegisterPage())
   ];

}