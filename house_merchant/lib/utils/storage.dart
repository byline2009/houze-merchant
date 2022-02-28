import 'package:flutter/material.dart';
import 'package:house_merchant/middle/model/language_model.dart';
import 'package:house_merchant/middle/model/token_model.dart';
import 'package:house_merchant/utils/app_contant.dart';
import 'package:house_merchant/utils/string_util.dart';
import 'package:house_merchant/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

const String API_TOKEN = 'api_token';
const String DEVICE_TOKEN = 'device_token';
const String LANGUAGE = 'language';

class Storage {
  static SharedPreferences? prefs;

  static GlobalKey<NavigatorState> scaffoldKey =
      new GlobalKey<NavigatorState>();

  // Token
  static Future<bool> saveToken(TokenModel token) {
    final prefs = Storage.prefs;
    return prefs!.setString(API_TOKEN, json.encode(token));
  }

  static Future<bool> removeToken() {
    final prefs = Storage.prefs;
    return prefs!.remove(API_TOKEN);
  }

  static TokenModel? getToken() {
    final prefs = Storage.prefs;
    String? token = prefs?.getString(API_TOKEN);
    if (token == null) {
      return null;
    }
    if (Utils.isEmpty(token)) {
      return null;
    }

    return TokenModel.fromJson(json.decode(token));
  }

  /// Device Token
  static void saveDeviceToken(String deviceToken) async {
    final prefs = Storage.prefs;
    prefs!.setString(DEVICE_TOKEN, deviceToken);
  }

  static String? getDeviceToken() {
    final prefs = Storage.prefs;
    String? strSignIn = prefs!.getString(DEVICE_TOKEN);
    if (StringUtil.isEmpty(strSignIn!)) {
      return null;
    }
    return strSignIn;
  }

  // Get language
  static LanguageModel getLanguage() {
    final prefs = Storage.prefs;
    String? strLanguage = prefs?.getString(LANGUAGE);
    LanguageModel item;
    if (StringUtil.isEmpty(strLanguage ?? "")) {
      item = AppConstant.languages[0];
    } else {
      item = LanguageModel.fromJson(json.decode(strLanguage ?? ""));
    }
    return item;
  }
}
