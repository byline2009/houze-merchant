
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:house_merchant/constant/api_constant.dart';
import 'package:house_merchant/middle/api/oauth_api.dart';
import 'package:house_merchant/utils/sqflite.dart';
import 'package:house_merchant/utils/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worker_manager/worker_manager.dart';

class AppConfig {

  static init({String env='.env.prod'}) async {

    // Instance SharedPreferences
    Storage.prefs = await SharedPreferences.getInstance();

    //Init Sqflite
    await Sqflite.init();

    //Init env
    await DotEnv().load(env);

    //API init
    APIConstant.init();

    //OAuth init
    OauthAPI.init();
  }

}