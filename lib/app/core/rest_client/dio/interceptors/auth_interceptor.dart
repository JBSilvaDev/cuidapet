// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_cuida_pet/app/core/helpers/constantes.dart';
import 'package:app_cuida_pet/app/modules/core/auth/auth_store.dart';
import 'package:dio/dio.dart';

import 'package:app_cuida_pet/app/core/local_storage/local_storage.dart';

class AuthInterceptor extends Interceptor {
  final LocalStorage _localStorage;
  final AuthStore _authStore;
  AuthInterceptor({
    required LocalStorage localStorage,
    required AuthStore authStore,
  })  : _localStorage = localStorage,
        _authStore = authStore;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final authRequired =
        options.extra[Constantes.REST_CLIENT_AUTH_REQUIRED_KEY] ?? false;

    if (authRequired) {
      final accessToken = await _localStorage
          .read<String>(Constantes.LOCAL_STORAGE_ACCESS_TOKEN_KEY);
      if (accessToken == null) {
        _authStore.logout();

        return handler.reject(
          DioException(
            requestOptions: options,
            error: 'Expire Token',
            type: DioExceptionType.cancel,
          ),
        );
      }
      options.headers['Authorization'] = accessToken;
    } else {
      options.headers.remove('Authorization');
    }
    handler.next(options);

    // super.onRequest(options, handler);
  }

  // @override
  // void onResponse(Response response, ResponseInterceptorHandler handler) {
  //   // super.onResponse(response, handler);
  // }

  // @override
  // void onError(DioException err, ErrorInterceptorHandler handler) {
  //   // super.onError(err, handler);
  // }
}
