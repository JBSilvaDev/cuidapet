import 'package:app_cuida_pet/app/modules/auth/home/auth_home_page.dart';
import 'package:app_cuida_pet/app/modules/auth/login/login_module.dart';
import 'package:app_cuida_pet/app/modules/auth/register/register_module.dart';
import 'package:app_cuida_pet/app/repositories/user_repository.dart';
import 'package:app_cuida_pet/app/repositories/user_repository_impl.dart';
import 'package:app_cuida_pet/app/services/user/user_service.dart';
import 'package:app_cuida_pet/app/services/user/user_service_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [
    Bind.lazySingleton<UserRepository>((i) => UserRepositoryImpl(
      log: i(),
      restClient: i()
    )),
    Bind.lazySingleton<UserService>((i) => UserServiceImpl(
      log: i(),
      repository: i()
    )),
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: (context, args) =>  AuthHomePage(authStore: Modular.get(),)),
            ModuleRoute('/login', module: LoginModule()),
            ModuleRoute('/register', module: RegisterModule()),
      ];
}
