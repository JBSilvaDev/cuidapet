import 'package:app_cuida_pet/app/core/rest_client/dio_rest_client.dart';
import 'package:app_cuida_pet/app/core/rest_client/rest_client.dart';
import 'package:app_cuida_pet/app/modules/core/auth/auth_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoreModule extends Module {

   @override
   List<Bind> get binds => [
    Bind.lazySingleton((i) => AuthStore(), export: true),
    Bind.lazySingleton<RestClient>((i) => DioRestClient(), export: true)
   ];


}