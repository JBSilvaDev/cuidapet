// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_cuida_pet/app/core/ui/widgets/loader.dart';
import 'package:mobx/mobx.dart';

import 'package:app_cuida_pet/app/core/logger/app_logger.dart';
import 'package:app_cuida_pet/app/services/user/user_service.dart';

part 'register_controller.g.dart';

class RegisterController = RegisterControllerBase with _$RegisterController;

abstract class RegisterControllerBase with Store {
  final AppLogger _log;

  final UserService _userService;
  RegisterControllerBase({
    required AppLogger log,
    required UserService userService,
  })  : _log = log,
        _userService = userService;

  void register({required String email, required String password}) async {
    Loader.show();
    await Future.delayed(Duration(seconds: 2), () {
      Loader.hide();
    });
  }
}
