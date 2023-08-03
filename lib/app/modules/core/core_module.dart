import 'package:app_cuida_pet/app/core/local_storage/flutter_secure_storage_local_storage/flutter_secure_str_local_impl.dart';
import 'package:app_cuida_pet/app/core/local_storage/local_storage.dart';
import 'package:app_cuida_pet/app/core/local_storage/shared_preference/shared_preference_local_storage_impl.dart';
import 'package:app_cuida_pet/app/core/logger/app_logger.dart';
import 'package:app_cuida_pet/app/core/logger/app_logger_impl.dart';
import 'package:app_cuida_pet/app/core/rest_client/dio/dio_rest_client.dart';
import 'package:app_cuida_pet/app/core/rest_client/rest_client.dart';
import 'package:app_cuida_pet/app/modules/core/auth/auth_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoreModule extends Module {

   @override
   List<Bind> get binds => [
    Bind.lazySingleton<AppLogger>((i) => AppLoggerImpl(), export:  true),
    Bind.lazySingleton<LocalStorage>((i) => SharedPreferenceLocalStorageImpl(), export:  true),
    Bind.lazySingleton<LocalSecureStorage>((i) => FlutterSecureStrLocalImpl(), export:  true),
    Bind.lazySingleton((i) => AuthStore(localStorage: i()), export: true),
    Bind.lazySingleton<RestClient>((i) => DioRestClient(localStorage: i(), log: i(), authStore: i(), localSecureStorage: i()), export: true,),

   ];


}