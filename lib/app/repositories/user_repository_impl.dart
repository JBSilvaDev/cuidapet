// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:app_cuida_pet/app/core/exceptions/user_exists_exception.dart';
import 'package:app_cuida_pet/app/core/logger/app_logger.dart';
import 'package:app_cuida_pet/app/core/rest_client/rest_client.dart';
import 'package:app_cuida_pet/app/core/rest_client/rest_client_exception.dart';
import 'package:app_cuida_pet/app/models/confirm_login_model.dart';
import 'package:app_cuida_pet/app/models/user_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../core/exceptions/failure.dart';
import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient _restClient;
  final AppLogger _log;
  UserRepositoryImpl({
    required RestClient restClient,
    required AppLogger log,
  })  : _log = log,
        _restClient = restClient;

  @override
  Future<void> register(String email, String password) async {
    try {
      await _restClient.unanth().post('/auth/register', data: {
        'email': email,
        'password': password,
      });
    } on RestClientException catch (e, s) {
      if (e.statusCode == 400 &&
          e.response.data['message']
              .toString()
              .contains('Usuario ja cadastrado')) {
        _log.error(e.error, e, s);
        throw UserExistsException();
      }
      _log.error('Erro ao cadastrar usuario', e, s);
      throw Failure(message: 'Erro ao registrar usuario');
    }
  }

  @override
  Future<String> login(String email, String password) async {
    try {
      final result = await _restClient.unanth().post('/auth/', data: {
        "login": email,
        "password": password,
        "social_login": false,
        "supplier_user": false
      });
      return result.data['access_token'];
    } on RestClientException catch (e, s) {
      if (e.statusCode == 403) {
        throw Failure(message: 'Usuario inconsistente conte o suporte!');
      }
      _log.error('Erro ao realizar login', e, s);
      throw Failure(
          message: 'Erro ao realizar login, tente novamente mais tarde');
    }
  }

  @override
  Future<ConfirmLoginModel> confirmLogin() async {
    try {
      final deviceToken = await FirebaseMessaging.instance.getToken();

      final result = await _restClient.auth().patch('/auth/confirm', data: {
        'ios_token': Platform.isIOS ? deviceToken : null,
        'android_token': Platform.isAndroid ? deviceToken : null
      });
      return ConfirmLoginModel.fromMap(result.data);
    } on RestClientException catch (e, s) {
      _log.error('Erro ao confirmar login', e, s);
      throw Failure(message: 'Erro ao confirmar login');
    }
  }

  @override
  Future<UserModel> getUserLogged() async {
    try {
  final result = await _restClient.get('/users/');
  return UserModel.fromMap(result.data);
} on RestClientException catch (e, s) {
  _log.error('Erro ao buscar dados de usuario logado', e, s);
  throw Failure(message: 'Erro ao buscar dados do usuario logado');

}
    
  }
}
