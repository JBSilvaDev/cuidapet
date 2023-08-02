import 'package:app_cuida_pet/app/core/helpers/enviroments.dart';
import 'package:app_cuida_pet/app/core/local_storage/local_storage.dart';
import 'package:app_cuida_pet/app/core/logger/app_logger.dart';
import 'package:app_cuida_pet/app/core/rest_client/dio/interceptors/auth_interceptor.dart';
import 'package:app_cuida_pet/app/core/rest_client/rest_client.dart';
import 'package:app_cuida_pet/app/core/rest_client/rest_client_response.dart';
import 'package:dio/dio.dart';

import '../../../modules/core/auth/auth_store.dart';
import '../../helpers/constantes.dart';
import '../rest_client_exception.dart';

class DioRestClient implements RestClient {
  late final Dio _dio;

  final _defaultOptions = BaseOptions(
      baseUrl: Enviroments.param(Constantes.ENV_BASE_URL_KEY) ?? '',
      connectTimeout: Duration(
          milliseconds: int.parse(
              Enviroments.param(Constantes.ENV_REST_CLIENT_CONNECT_TIMEOUT) ??
                  '0')),
      receiveTimeout: Duration(
          milliseconds: int.parse(
              Enviroments.param(Constantes.ENV_REST_CLIENT_RECEIVE_TIMEOUT) ??
                  '0')));

  DioRestClient({
    required LocalStorage localStorage,
    required AppLogger log,
    required AuthStore authStore,
    BaseOptions? baseOptions,
  }) {
    _dio = Dio(baseOptions ?? _defaultOptions);
    _dio.interceptors.addAll([
      AuthInterceptor(localStorage: localStorage, authStore: authStore),
      LogInterceptor(requestBody: true, responseBody: true),
    ]);
  }

  @override
  RestClient auth() {
    _defaultOptions.extra[Constantes.REST_CLIENT_AUTH_REQUIRED_KEY] = true;
    return this;
  }

  @override
  RestClient unanth() {
    _defaultOptions.extra[Constantes.REST_CLIENT_AUTH_REQUIRED_KEY] = false;
    return this;
  }

  @override
  Future<RestClientResponse<T>> delete<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.delete(path,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers));
      return _diosResponseConverter(response);
    } on DioException catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.get(path,
          queryParameters: queryParameters, options: Options(headers: headers));
      return _diosResponseConverter(response);
    } on DioException catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> patch<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.patch(path,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers));
      return _diosResponseConverter(response);
    } on DioException catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> post<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.post(path,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers));
      return _diosResponseConverter(response);
    } on DioException catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> put<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.put(path,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers));
      return _diosResponseConverter(response);
    } on DioException catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> request<T>(String path,
      {required String method,
      data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.request(path,
          data: data,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
            method: method,
          ));
      return _diosResponseConverter(response);
    } on DioException catch (e) {
      _throwRestClientException(e);
    }
  }

  Future<RestClientResponse<T>> _diosResponseConverter<T>(
      Response<dynamic> response) async {
    return RestClientResponse<T>(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage);
  }

  Never _throwRestClientException(DioException dioError) {
    throw RestClientException(
      message: dioError.response?.statusMessage,
      error: dioError.error,
      statusCode: dioError.response?.statusCode,
      response: RestClientResponse(
          data: dioError.response?.data,
          statusCode: dioError.response?.statusCode,
          statusMessage: dioError.response?.statusMessage),
    );
  }
}
