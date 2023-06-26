// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_cuida_pet/app/core/exceptions/user_exists_exception.dart';
import 'package:app_cuida_pet/app/core/ui/widgets/loader.dart';
import 'package:app_cuida_pet/app/core/ui/widgets/messages.dart';
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
    try {
      Loader.show();
      await _userService.register(email, password);
      Loader.hide();
      Messages.info(
          'E-mail de confirmação enviado, favor clique no link para confirmar seu cadastro');
          
    } on UserExistsException {
      Loader.hide();

      Messages.alert(
          'Email ja utilizado anteriormente, clique em esqueci a senha para recupera-lo');
    } catch (e, s) {
      _log.error('Erro ao registrar usuario', e, s);
      Loader.hide();
      Messages.alert('Erro ao registrar usuario');
    }
  }
}
