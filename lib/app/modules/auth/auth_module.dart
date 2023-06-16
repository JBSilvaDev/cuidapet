import 'package:app_cuida_pet/app/modules/auth/home/auth_home_page.dart';
import 'package:app_cuida_pet/app/modules/auth/login/login_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: (context, args) =>  AuthHomePage(authStore: Modular.get(),)),
            ModuleRoute('/login', module: LoginModule())
      ];
}
