
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:house_merchant/constant/api_constant.dart';
import 'package:house_merchant/middle/api/oauth_api.dart';
import 'package:house_merchant/utils/sqflite.dart';
import 'package:house_merchant/utils/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {

  static init(String env) async {

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