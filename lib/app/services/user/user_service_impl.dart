// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_cuida_pet/app/core/exceptions/failure.dart';
import 'package:app_cuida_pet/app/core/exceptions/user_exists_exception.dart';
import 'package:app_cuida_pet/app/core/logger/app_logger.dart';
import 'package:app_cuida_pet/app/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'user_service.dart';

class UserServiceImpl implements UserService {
  final AppLogger _log;
  final UserRepository _repository;
  UserServiceImpl({
    required AppLogger log,
    required UserRepository repository,
  })  : _log = log,
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
}
