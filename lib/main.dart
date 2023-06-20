import 'package:app_cuida_pet/app/modules/app_module.dart';
import 'package:app_cuida_pet/app/modules/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  ));
}
