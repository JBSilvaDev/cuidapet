// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_cuida_pet/app/models/user_model.dart';
import 'package:flutter/material.dart';

import 'package:app_cuida_pet/app/core/ui/extensions/size_screen_extension.dart';
import 'package:app_cuida_pet/app/modules/core/auth/auth_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class AuthHomePage extends StatefulWidget {
  final AuthStore _authStore;
  const AuthHomePage({
    Key? key,
    required AuthStore authStore,
  })  : _authStore = authStore,
        super(key: key);

  @override
  State<AuthHomePage> createState() => _AuthHomePageState();
}

class _AuthHomePageState extends State<AuthHomePage> {
  @override
  void initState() {
    reaction<UserModel?>((_) => widget._authStore.userLogged, (userLogger) {
      if (userLogger != null && userLogger.email.isNotEmpty) {

        Modular.to.navigate('/home');
      } else {
        Modular.to.navigate('/auth/login');
        
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget._authStore.loadUserLogged();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          // .w & .h vem do flutter_screenutil/size_screen_extension
          width: 162.w,
          height: 130.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
