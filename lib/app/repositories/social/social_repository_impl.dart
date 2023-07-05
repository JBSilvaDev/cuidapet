// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_cuida_pet/app/core/logger/app_logger.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:app_cuida_pet/app/core/exceptions/failure.dart';
import 'package:app_cuida_pet/app/models/social_network_model.dart';

import './social_repository.dart';

class SocialRepositoryImpl implements SocialRepository {
  final AppLogger _log;
  SocialRepositoryImpl({
    required AppLogger log,
  }) : _log = log;
  // @override
  // Future<SocialNetworkModel> facebookLogin() async {
  //   final facebookAuth = FacebookAuth.instance;
  //   final result = await facebookAuth.login();
  //   switch (result.status) {
  //     case LoginStatus.success:
  //       final userData = await facebookAuth.getUserData();
  //       return SocialNetworkModel(
  //         id: userData['id'],
  //         name: userData['name'],
  //         email: userData['email'],
  //         type: 'Facebook',
  //         avatar: userData['picture']['data']['url'],
  //         accessToken: result.accessToken?.token ?? ''
  //       );

  //     case LoginStatus.cancelled:
  //       throw Failure(message: 'Login cancelado');

  //     case LoginStatus.failed:
  //     case LoginStatus.operationInProgress:
  //       throw Failure(message: 'Falha ao realizar login');
  //   }
  // }

  @override
  Future<SocialNetworkModel> googleLogin() async {
    final googleSignIn = GoogleSignIn();
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.disconnect();
    }
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser?.authentication;

    if (googleAuth != null && googleUser != null) {
      return SocialNetworkModel(
        id: googleAuth.idToken ?? '',
        name: googleUser.displayName ?? '',
        email: googleUser.email,
        type: 'Google',
        avatar: googleUser.photoUrl,
        accessToken: googleAuth.accessToken ?? '',
      );
    } else {
      _log.error('Erro ao realizar login com google');

      throw Failure(message: 'Erro ao realizar login com google');
    }
  }
}
