import 'package:flutter/material.dart';
import 'package:app_cuida_pet/app/core/ui/extensions/size_screen_extension.dart';

class AuthHomePage extends StatelessWidget {
  const AuthHomePage({super.key});

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
