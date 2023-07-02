import 'dart:convert';

class UserModel {
  final String email;
  final String registerType;
  final String imgAvatar;
  UserModel({
    required this.email,
    required this.registerType,
    required this.imgAvatar,
  });

  UserModel.empty() : email = '', registerType = '', imgAvatar = '';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'register_type': registerType,
      'image_avatar': imgAvatar,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      registerType: map['register_type'] ?? '',
      imgAvatar: map['image_avatar'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
