// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_cuida_pet/app/core/exceptions/failure.dart';
import 'package:app_cuida_pet/app/core/exceptions/user_exists_exception.dart';
import 'package:app_cuida_pet/app/core/exceptions/user_not_exists_exception.dart';
import 'package:app_cuida_pet/app/core/helpers/constantes.dart';
import 'package:app_cuida_pet/app/core/local_storage/local_storage.dart';
import 'package:app_cuida_pet/app/core/logger/app_logger.dart';
import 'package:app_cuida_pet/app/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'user_service.dart';

class UserServiceImpl implements UserService {
  final AppLogger _log;
  final UserRepository _repository;
  final LocalStorage _localStorage;
  final LocalSecureStorage _localSecureStore;
  UserServiceImpl({
    required AppLogger log,
    required UserRepository repository,
    required LocalSecureStorage localSecureStore,
    required LocalStorage localStorage,
  })  : _log = log,
        _localSecureStore = localSecureStore,
        _localStorage = localStorage,
        _repository = repository;

  @override
  Future<void> register(String email, String password) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;

      final userMethod = await firebaseAuth.fetchSignInMethodsForEmail(email);

      if (userMethod.isNotEmpty) {
        throw UserExistsException();
      }
      await _repository.register(email, password);

      final userRegister = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      await userRegister.user?.sendEmailVerification();
    } on FirebaseException catch (e, s) {
      _log.error('Erro ao criar usuario no firebase', e, s);
      Failure(message: 'Erro ao criar usuario');
    }
  }

  @override
  Future<void> login(String email, String password) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;
      final loginMethods = await firebaseAuth.fetchSignInMethodsForEmail(email);
      if (loginMethods.isEmpty) {
        throw UserNotExistsException();
      }
      if (loginMethods.contains('password')) {
        final userCredential = await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        final userVerified = userCredential.user?.emailVerified ?? false;
        if (!userVerified) {
          userCredential.user?.sendEmailVerification();

          throw Failure(message: 'E-mail ainda não verificado!');
        }
        final accessToken = await _repository.login(email, password);
        await _saveAccessToken(accessToken);
        await _confirmLogin();
      } else {
        throw Failure(message: 'Login nao pode ser feito por e-mail e senha');
      }

      print(loginMethods);
    } on FirebaseAuthException catch (e, s) {
      _log.error('Usuario ou senha invalidos no firebase [${e.code}]', e, s);
      throw Failure(message: 'Usuario ou senha invalidos');
    }
  }

  Future<void> _saveAccessToken(String accessToken) => _localStorage.write(
      Constantes.LOCAL_STORAGE_ACCESS_TOKEN_KEY, accessToken);

  Future<void> _confirmLogin() async {
    final confirmLoginModel = await _repository.confirmLogin();
    await _saveAccessToken(confirmLoginModel.accessToken);
    await _localSecureStore.write(Constantes.LOCAL_STORAGE_REFRESH_TOKEN_KEY,
        confirmLoginModel.refreshToken);

  }
}
