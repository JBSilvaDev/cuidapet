// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_cuida_pet/app/core/exceptions/user_not_exists_exception.dart';
import 'package:app_cuida_pet/app/core/ui/widgets/loader.dart';
import 'package:app_cuida_pet/app/core/ui/widgets/messages.dart';
import 'package:app_cuida_pet/app/models/social_login_type.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:app_cuida_pet/app/core/logger/app_logger.dart';
import 'package:app_cuida_pet/app/services/user/user_service.dart';

import '../../../../core/exceptions/failure.dart';

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
    try {
      Loader.show();
      await _userService.login(login, password);

      Loader.hide();
      Modular.to.navigate('/auth/');
    } on Failure catch (e, s) {
      _log.error(e.message ?? '', e, s);

      Loader.hide();
      Messages.alert(e.message ?? 'Erro ao realizar login');
    } on UserNotExistsException catch (e, s) {
      _log.error('Usuario nao encontrado', e, s);

      Loader.hide();
      Messages.alert('Usuario nao cadastrado');
    }
  }

  Future<void> socialLogin(SocialLoginType socialType) async {
    try {
      Loader.show();
      await _userService.socialLogin(socialType);

      Loader.hide();
      Modular.to.navigate('/auth/');
      
    } on Failure catch (e, s) {
      Loader.hide();

      _log.error('Erro ao realizar login social', e, s);

      Messages.alert(e.message ?? 'Erro ao realizar login');

    }
  }
}
