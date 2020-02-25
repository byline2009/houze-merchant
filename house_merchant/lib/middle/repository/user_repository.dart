import 'package:flutter/foundation.dart';
import 'package:house_merchant/middle/api/login_api.dart';
import 'package:house_merchant/middle/model/token_model.dart';
import 'package:house_merchant/utils/storage.dart';
import 'package:meta/meta.dart';

class UserRepository {

  final loginAPI = new LoginAPI();

  UserRepository() {
    print('UserRepository init');
  }

  Future<String> authenticate({
    @required String username,
    @required String password,
    String phoneDial,
  }) async {
    
    //await Future.delayed(Duration(milliseconds: 1000));

    var token = "";

    try {
      //Call Dio API
      final rs = await loginAPI.login(username: username, password: password);

      if (rs != null) {
        token = rs.access;
        Storage.saveToken(rs);
      }

    } catch (e) {
      return throw(e.toString());
    } finally {
      //integrate Feed API
    }

    return token;

  }

  Future<void> deleteToken() async {
    Storage.removeToken();
    //feedAPI.UnRegisterDeviceToken();
    return;
  }


  Future<void> persistToken(TokenModel token) async {
    Storage.saveToken(token);
    return;
  }

  Future<bool> hasToken() async {
    final token = Storage.getToken();
    return token != null;
  }
}