import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class CustomDio extends DioForNative {
  CustomDio()
      : super(
          BaseOptions(
            baseUrl: 'https://sys-dev.searchandstay.com/api/admin',
            connectTimeout: const Duration(milliseconds: 5000),
            receiveTimeout: const Duration(milliseconds: 60000),
          ),
        ) {
    interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
      requestHeader: true,
    ));
  }

  CustomDio auth() {
    options.headers['Authorization'] =
        'Bearer 40fe071962846075452a4f6123ae71697463cad20f51e237e2035b41af0513d8';
    return this;
  }

  CustomDio unauth() {
    return this;
  }
}
