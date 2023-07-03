// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_cuida_pet/app/core/exceptions/failure.dart';
import 'package:app_cuida_pet/app/core/exceptions/user_exists_exception.dart';
import 'package:app_cuida_pet/app/core/exceptions/user_not_exists_exception.dart';
import 'package:app_cuida_pet/app/core/helpers/constantes.dart';
import 'package:app_cuida_pet/app/core/local_storage/local_storage.dart';
import 'package:app_cuida_pet/app/core/logger/app_logger.dart';
import 'package:app_cuida_pet/app/models/social_login_type.dart';
import 'package:app_cuida_pet/app/models/social_network_model.dart';
import 'package:app_cuida_pet/app/repositories/social/social_repository.dart';
import 'package:app_cuida_pet/app/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'user_service.dart';

class UserServiceImpl implements UserService {
  final AppLogger _log;
  final UserRepository _repository;
  final LocalStorage _localStorage;
  final LocalSecureStorage _localSecureStore;
  final SocialRepository _socialRepository;
  UserServiceImpl(
      {required AppLogger log,
      required UserRepository repository,
      required LocalSecureStorage localSecureStore,
      required LocalStorage localStorage,
      required SocialRepository socialRepository})
      : _log = log,
        _localSecureStore = localSecureStore,
        _localStorage = localStorage,
        _socialRepository = socialRepository,
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
        await _getUserData();
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

  Future<void> _getUserData() async {
    final userModel = await _repository.getUserLogged();
    await _localStorage.write(
        Constantes.LOCAL_STORAGE_USER_LOGGED_DATA_KEY, userModel.toJson());
  }

  @override
  Future<void> socialLogin(SocialLoginType socialLoginType) async {
    try {
  final SocialNetworkModel socialModel;
  final AuthCredential authCredential;
  final firebaseAuth = FirebaseAuth.instance;
  switch (socialLoginType) {
    case SocialLoginType.facebook:
      throw Exception();
  
    case SocialLoginType.google:
      socialModel = await _socialRepository.googleLogin();
      authCredential = GoogleAuthProvider.credential(
        accessToken: socialModel.accessToken,
        idToken: socialModel.id,
      );
  
      break;
  }
  final loginMethods =
      await firebaseAuth.fetchSignInMethodsForEmail(socialModel.email);
  final methodCheck = _getMethodToSocialLoginType(socialLoginType);
  if (loginMethods.isNotEmpty && !loginMethods.contains(methodCheck)) {
    throw Failure(
        message: 'Login nao pode ser feito por conta tipo $methodCheck');
  }
  await firebaseAuth.signInWithCredential(authCredential);
  final accessToken = await _repository.loginSocial(socialModel);
  await _saveAccessToken(accessToken);
  await _confirmLogin();
  await _getUserData();
} on FirebaseAuthException catch (e, s) {
  _log.error('Erro ao realizar login com $socialLoginType', e, s);
  throw Failure(message: 'Erro ao realizar login');
  
}
  }

  String _getMethodToSocialLoginType(SocialLoginType socialLoginType) {
    switch (socialLoginType) {
      case SocialLoginType.facebook:
        return 'facebook.com';
      case SocialLoginType.google:
        return 'google.com';
    }
  }
}
