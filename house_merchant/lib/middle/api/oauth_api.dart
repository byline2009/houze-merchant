import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_merchant/constant/api_constant.dart';
import 'package:house_merchant/constant/common_constant.dart';
import 'package:house_merchant/middle/api/error_response.dart';
import 'package:house_merchant/middle/bloc/authentication/authentication_bloc.dart';
import 'package:house_merchant/middle/bloc/authentication/authentication_event.dart';
import 'package:house_merchant/middle/model/token_model.dart';
import 'package:house_merchant/providers/log_provider.dart';
import 'package:house_merchant/utils/sqflite.dart';
import 'package:house_merchant/utils/storage.dart';
import 'package:synchronized/synchronized.dart' as lock;

class OauthAPI {
  static String tokenType = "Bearer";
  static Dio? dioInstance;
  static Dio? tokenDioInstance;

  static String? token;
  static bool tokenValid = true;

  String? refreshAPI;
  BaseOptions? options;
  static lock.Lock? synchronized;
  static LogProvider get logger => const LogProvider('✅ OauthAPI');

  static void init() {
    if (OauthAPI.tokenDioInstance == null) {
      OauthAPI.synchronized = new lock.Lock();
      OauthAPI.tokenDioInstance = new Dio();

      //Refresh token failed
      //A refresh token only refresh 1 times.
      OauthAPI.tokenDioInstance!.interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options, handler) {
            logger.log('[${options.method}] - ${options.uri}');
            return handler.next(options);
          },
          onResponse: (Response response, handler) {
            return handler.next(response);
          },
          onError: (DioError e, handler) {
            logger.log(e.response.toString());

            return handler.next(e);
          },
        ),
      );
    }

    final refreshAPI = getApiUrl('/oauth/api-token-refresh/');

    if (OauthAPI.dioInstance == null) {
      //First declare
      OauthAPI.dioInstance = new Dio();
      OauthAPI.dioInstance!.options.connectTimeout = 7000;
      OauthAPI.dioInstance!.options.receiveTimeout = 15000;

      //handler expire token
      OauthAPI.dioInstance!.interceptors.add(InterceptorsWrapper(
          onRequest: (RequestOptions options, handler) async {
        debugPrint(
            "${DateTime.now()} BEGIN REQUEST: ${options.path} with method: ${options.method}");

        final TokenModel? tokens = Storage.getToken();
        OauthAPI.token = tokens!.access;
        final _language = Storage.getLanguage();

        options.headers["Authorization"] =
            "${CommonConstant.tokenType} ${OauthAPI.token}";
        options.headers["token"] = tokens.access;
        options.headers["refresh"] = tokens.refresh;
        options.headers["language"] = _language.locale;
        options.headers["Accept-Language"] = _language.locale;
        //Log header and token
        logger.log(options.headers.toString());
        logger.log("Request with access token: ${options.headers["token"]}");
        return handler.next(options);
      }, onResponse: (Response response, handler) {
        if (response.requestOptions.method == "GET")
          Sqflite.insertResponse(response);

        return handler.next(response);
      }, onError: (DioError e, handler) async {
        if (e.type == DioErrorType.connectTimeout ||
            e.type == DioErrorType.receiveTimeout) {
          throw Error.safeToString(
              "Server is not reachable. Please verify your internet connection and try again");
        }

        if (OauthAPI.token != null && e.response?.statusCode == 401) {
          //debugPrint("${DateTime.now()} END 401 REQUEST: ${e.request.path}");
          await OauthAPI.synchronized!.synchronized(() {
            OauthAPI.tokenValid = false;
          });

          //expire token
          RequestOptions requestOptions = e.response!.requestOptions;

          //If the token has been updated, repeat directly.
          //Processing for asynchronous
          Options options = Options(
            method: requestOptions.method,
            headers: requestOptions.headers,
          );

          //If the token has been updated, repeat directly.
          if (OauthAPI.token != options.headers?["token"]) {
            requestOptions.headers["Authorization"] =
                "${OauthAPI.tokenType} ${OauthAPI.token}";
            requestOptions.headers["token"] = OauthAPI.token;
            return handler
                .resolve(await OauthAPI.dioInstance!.fetch(requestOptions));
          }

          print("############################");
          print(
              "* ${e.response?.statusCode}: refresh token with path: ${e.requestOptions.path} and accessToken: ${OauthAPI.token}");
          print("############################");

          // dioLock();
          OauthAPI.dioInstance!.lock();

          return await OauthAPI.synchronized!.synchronized(() {
            print(
                '${DateTime.now()} BEGIN synchronized lock ${OauthAPI.tokenValid}');
            final TokenModel? token = Storage.getToken();

            if (OauthAPI.tokenValid == true) {
              requestOptions.headers["Authorization"] =
                  "${CommonConstant.tokenType} ${OauthAPI.token}";
              requestOptions.headers["token"] = OauthAPI.token;
              return OauthAPI.dioInstance!.fetch(requestOptions);
            }

            return OauthAPI.tokenDioInstance!
                .post(refreshAPI,
                    data: {"refresh": token!.refresh},
                    options: Options(headers: {"refresh": token.refresh}))
                .then((d) async {
              print(
                  "* New token refresh: ${d.data["refresh"]}, access: ${d.data["access"]} for path: ${e.requestOptions.path}");

              OauthAPI.token = d.data["access"];
              requestOptions.headers["Authorization"] =
                  "${CommonConstant.tokenType} ${OauthAPI.token}";
              requestOptions.headers["token"] = d.data["access"];

              Storage.saveToken(TokenModel(
                  access: d.data["access"], refresh: d.data["refresh"]));
              OauthAPI.tokenValid = true;
            }).whenComplete(() {
              // dioUnlock();
              OauthAPI.dioInstance!.unlock();
            }).catchError((e) async {
              if (e.response?.statusCode == 401) {
                Fluttertoast.showToast(
                    msg:
                        "Phiên đăng nhập của bạn đã hết hạn. Vui lòng đăng nhập lại.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 5,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 14.0);

                BlocProvider.of<AuthenticationBloc>(
                    Storage.scaffoldKey.currentContext!)
                  ..add(LoggedOut());

                return e;
              }

              print('catch then refresh token ..... ${requestOptions.path}');
              requestOptions.headers["Authorization"] =
                  "${CommonConstant.tokenType} ${OauthAPI.token}";
              requestOptions.headers["token"] = OauthAPI.token;
              final request =
                  await OauthAPI.dioInstance!.request(requestOptions.path,
                      options: Options(
                        method: requestOptions.method,
                        headers: requestOptions.headers,
                      ),
                      data: requestOptions.data,
                      queryParameters: requestOptions.queryParameters);

              handler.resolve(request);
            }).then((ex) async {
              print('then refresh token ..... ${requestOptions.path}');
              try {
                final request =
                    await OauthAPI.dioInstance!.request(requestOptions.path,
                        options: Options(
                          method: requestOptions.method,
                          headers: requestOptions.headers,
                        ),
                        data: requestOptions.data,
                        queryParameters: requestOptions.queryParameters);
                return handler.resolve(request);
              } on DioError catch (error) {
                handler.next(error); // or handler.reject(error);
              }
            });
          });
        }

        return handler.next(e);
      }));
    }
  }

  // static void dioLock() {
  //   //OauthAPI.dioInstance.lock();
  //   OauthAPI.dioInstance!.interceptors.requestLock.lock();
  //   OauthAPI.dioInstance!.interceptors.responseLock.lock();
  // }

  // static void dioUnlock() {
  //   //OauthAPI.dioInstance.unlock();
  //   OauthAPI.dioInstance!.interceptors.requestLock.unlock();
  //   OauthAPI.dioInstance!.interceptors.responseLock.unlock();
  // }

  Future<Response> get(
    String? path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    final response = dioInstance!.get(
      path ?? "",
      queryParameters: queryParameters,
      options: options,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );

    if (response is! ErrorResponse) {
      return response;
    }
    throw response;
  }

  Future<Response> post(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final response = dioInstance!.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );

    if (response is! ErrorResponse) {
      return response;
    }
    throw response;
  }

  Future<Response> put(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    final response = dioInstance!.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );

    if (response is! ErrorResponse) {
      return response;
    }
    throw response;
  }

  Future<Response> patch(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    final response = dioInstance!.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );

    if (response is! ErrorResponse) {
      return response;
    }
    throw response;
  }

  Future<Response> delete(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = dioInstance!.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );

    if (response is! ErrorResponse) {
      return response;
    }
    throw response;
  }

  static getApiUrl(String path) {
    return APIConstant.baseMerchantUrl! + path;
  }
}
