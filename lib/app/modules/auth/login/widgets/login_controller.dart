// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_cuida_pet/app/core/ui/widgets/loader.dart';
import 'package:mobx/mobx.dart';

import 'package:app_cuida_pet/app/core/logger/app_logger.dart';
import 'package:app_cuida_pet/app/services/user/user_service.dart';

part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  final UserService _userService;
  final AppLogger _log;
  LoginControllerBase({
    required UserService userService,
    required AppLogger log,
  })  : _log = log,
        _userService = userService;

  Future<void> login(String login, String password) async {
    Loader.show();
    await Future.delayed(Duration(seconds: 2));
    Loader.hide();
  }
}
