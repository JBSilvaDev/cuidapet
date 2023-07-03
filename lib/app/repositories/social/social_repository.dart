import '../../models/social_network_model.dart';

abstract interface class SocialRepository {
  Future<SocialNetworkModel> googleLogin();
  Future<SocialNetworkModel> facebookLogin();
}
