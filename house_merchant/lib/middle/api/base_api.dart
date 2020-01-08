import 'package:dio/dio.dart';

class BaseAPI {

  final String baseUrl;

  Dio dio;

  BaseAPI(this.baseUrl) {
    this.dio = new Dio();
    dio.options.baseUrl = this.baseUrl;
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 10000;

    this.dio.interceptors.add(InterceptorsWrapper(
      onRequest:(RequestOptions options) {
        return options;
      },
      onResponse:(Response response) {
        return response;
      },
      onError: (DioError e) {
        return e;
      }
    ));
  }

}