import 'package:dio/dio.dart';
import 'package:house_merchant/utils/sqflite.dart';

class BaseApi {
  final String baseUrl;
  Dio? dio;
  BaseApi(this.baseUrl) {
    this.dio = new Dio();
    dio!.options.baseUrl = this.baseUrl;
    dio!.options.connectTimeout = 5000; //5s
    dio!.options.receiveTimeout = 10000;
    this
        .dio!
        .interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options, handler) {
          return handler.next(options);
        }, onResponse: (Response response, handler) {
          if (response.requestOptions.method == "GET")
            Sqflite.insertResponse(response);
          return handler.next(response);
        }, onError: (DioError e, handler) {
          if (<DioErrorType>[
            DioErrorType.other,
            DioErrorType.connectTimeout,
            DioErrorType.receiveTimeout,
          ].contains(e.type)) {
            if (e.requestOptions.method == "GET")
              Sqflite.getCachingResponse(e);
            else
              throw e;
          }

          return handler.next(e);
        }));
  }
}
