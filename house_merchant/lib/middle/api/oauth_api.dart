import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_merchant/constant/api_constant.dart';
import 'package:house_merchant/constant/common_constant.dart';
import 'package:house_merchant/middle/bloc/authentication/authentication_bloc.dart';
import 'package:house_merchant/middle/bloc/authentication/authentication_event.dart';
import 'package:house_merchant/middle/model/token_model.dart';
import 'package:house_merchant/utils/storage.dart';
import 'package:synchronized/synchronized.dart' as lock;

class OauthAPI {
  static String tokenType = "Bearer";
  static Dio dioInstance;
  static Dio tokenDioInstance;

  static String token;
  static bool tokenValid = true;

  String refreshAPI;
  BaseOptions options;
  static lock.Lock synchronized;

  static void init() {
    if (OauthAPI.tokenDioInstance == null) {
      OauthAPI.synchronized = new lock.Lock();
      OauthAPI.tokenDioInstance = new Dio();

      //Refresh token failed
      //A refresh token only refresh 1 times.
      OauthAPI.tokenDioInstance.interceptors.add(InterceptorsWrapper(
          onRequest: (RequestOptions options) async {
            return options;
          },
          onResponse: (Response response) {
            return response;
          },
          onError: (DioError e) {}));
    }

    final refreshAPI = getApiUrl('/oauth/api-token-refresh/');

    if (OauthAPI.dioInstance == null) {
      //First declare
      OauthAPI.dioInstance = new Dio();
      OauthAPI.dioInstance.options.connectTimeout = 7000;
      OauthAPI.dioInstance.options.receiveTimeout = 15000;

      //handler expire token
      OauthAPI.dioInstance.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
        debugPrint(
            "${DateTime.now()} BEGIN REQUEST: ${options.path} with method: ${options.method}");

        final TokenModel tokens = Storage.getToken();
        OauthAPI.token = tokens.access;

        options.headers["Authorization"] =
            "${CommonConstant.tokenType} ${OauthAPI.token}";
        options.headers["token"] = tokens.access;
        options.headers["refresh"] = tokens.refresh;
        return options;
      }, onResponse: (Response response) {
        return response;
      }, onError: (DioError e) async {
        if (e.type == DioErrorType.CONNECT_TIMEOUT ||
            e.type == DioErrorType.RECEIVE_TIMEOUT) {
          throw Error.safeToString(
              "Server is not reachable. Please verify your internet connection and try again");
        }

        if (OauthAPI.token != null && e.response?.statusCode == 401) {
          //debugPrint("${DateTime.now()} END 401 REQUEST: ${e.request.path}");
          await OauthAPI.synchronized.synchronized(() {
            OauthAPI.tokenValid = false;
          });

          //expire token
          RequestOptions options = e.response.request;

          //If the token has been updated, repeat directly.
          //Processing for asynchronous
          if (OauthAPI.token != options.headers["token"]) {
            print('If the token has been updated, repeat directly.');
            options.headers["Authorization"] =
                "${CommonConstant.tokenType} ${OauthAPI.token}";
            options.headers["token"] = OauthAPI.token;
            return OauthAPI.dioInstance.request(options.path, options: options);
          }

          print("############################");
          print(
              "* ${e.response?.statusCode}: refresh token with path: ${e.request.path} and accessToken: ${OauthAPI.token}");
          print("############################");

          dioLock();

          return await OauthAPI.synchronized.synchronized(() {
            print(
                '${DateTime.now()} BEGIN synchronized lock ${OauthAPI.tokenValid}');
            final TokenModel token = Storage.getToken();

            if (OauthAPI.tokenValid == true) {
              options.headers["Authorization"] =
                  "${CommonConstant.tokenType} ${OauthAPI.token}";
              options.headers["token"] = OauthAPI.token;
              return OauthAPI.dioInstance
                  .request(options.path, options: options);
            }

            return OauthAPI.tokenDioInstance
                .post(refreshAPI,
                    data: {"refresh": token.refresh},
                    options: Options(headers: {"refresh": token.refresh}))
                .then((d) async {
              print(
                  "* New token refresh: ${d.data["refresh"]}, access: ${d.data["access"]} for path: ${e.request.path}");

              OauthAPI.token = d.data["access"];
              options.headers["Authorization"] =
                  "${CommonConstant.tokenType} ${OauthAPI.token}";
              options.headers["token"] = d.data["access"];

              Storage.saveToken(TokenModel(
                  access: d.data["access"], refresh: d.data["refresh"]));
              OauthAPI.tokenValid = true;
            }).whenComplete(() {
              dioUnlock();
            }).catchError((e) {
              if (e.response?.statusCode == 401) {
                Fluttertoast.showToast(
                    msg:
                        "Your session ended because there was no activity. Try signing in again.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 5,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 14.0);

                BlocProvider.of<AuthenticationBloc>(
                    Storage.scaffoldKey.currentContext)
                  ..add(LoggedOut());

                return e;
              }

              print('catch then refresh token ..... ${options.path}');
              options.headers["Authorization"] =
                  "${CommonConstant.tokenType} ${OauthAPI.token}";
              options.headers["token"] = OauthAPI.token;
              return OauthAPI.dioInstance
                  .request(options.path, options: options);
            }).then((ex) {
              print('then refresh token ..... ${options.path}');
              return OauthAPI.dioInstance
                  .request(options.path, options: options);
            });
          });
        }

        return e;
      }));
    }
  }

  static void dioLock() {
    //OauthAPI.dioInstance.lock();
    OauthAPI.dioInstance.interceptors.requestLock.lock();
    OauthAPI.dioInstance.interceptors.responseLock.lock();
  }

  static void dioUnlock() {
    //OauthAPI.dioInstance.unlock();
    OauthAPI.dioInstance.interceptors.requestLock.unlock();
    OauthAPI.dioInstance.interceptors.responseLock.unlock();
  }

  Future<dynamic> get(
    String path, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) async {
    var response = dioInstance.get(
      path,
      queryParameters: queryParameters,
      options: options,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );

    return response;
  }

  Future<dynamic> post(
    String path, {
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) async {
    var response = dioInstance.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );

    return response;
  }

  Future<dynamic> put(
    String path, {
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) async {
    var response = dioInstance.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );

    return response;
  }

  Future<dynamic> patch(
    String path, {
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) async {
    var response = dioInstance.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );

    return response;
  }

  Future<dynamic> delete(
    String path, {
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
  }) async {
    var response = dioInstance.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );

    return response;
  }

  static getApiUrl(String path) {
    return APIConstant.baseMerchantUrl + path;
  }
}
