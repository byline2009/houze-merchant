import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:house_merchant/middle/model/shop_model.dart';
import 'package:house_merchant/utils/custom_exception.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Sqflite {
  static Database? db;
  static const int version = 2;
  static const String database_name = "shop.db";
  static String current_shop = "";

  static Future init() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, database_name);

    try {
      debugPrint("Sqflite init in path: $path");
      db = await openDatabase(
        path,
        version: version,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE IF NOT EXISTS user_setting (key TEXT, value TEXT)');
          await db.execute(
              'CREATE TABLE IF NOT EXISTS responses (path TEXT PRIMARY KEY, data TEXT)');
        },
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
          await db.execute(
              'CREATE TABLE IF NOT EXISTS responses (path TEXT PRIMARY KEY, data TEXT)');
        },
      );
    } catch (e) {
      print("Error $e");
    }
  }

  static Future flush() async {
    await db!.rawUpdate('DELETE FROM user_setting');
    await db?.rawUpdate('DELETE FROM responses');
  }

  static Future<void> insertResponse(Response response) async {
    // Get a reference to the database.

    final String pathWithParams = response.requestOptions.path +
        getParamsPath(response.requestOptions.queryParameters);

    final Map<String, dynamic> instance = {
      "path": pathWithParams,
      "data": json.encode(response.data),
    };

    await db?.insert(
      'responses',
      instance,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<String> getCachingResponse(DioError error) async {
    // Get a reference to the database.

    final String pathWithParams = error.requestOptions.path +
        getParamsPath(error.requestOptions.queryParameters);

    try {
      final Map<String, dynamic> cachingResponse = (await db?.rawQuery(
        'SELECT data FROM responses WHERE path = "$pathWithParams" LIMIT 1',
      ))!
          .single;

      return cachingResponse['data'];
    } on StateError {
      if (!error.requestOptions.queryParameters.containsKey('offset') ||
          <dynamic>[0, null].any((e) =>
              e ==
              error.requestOptions.queryParameters.entries
                  .firstWhere((e) => e.key == 'offset')
                  .value))
        throw NoDataException();
      else {
        throw NoDataToLoadMoreException();
      }
    }
  }

  static Future<String?> currentShop() async {
    if (Sqflite.current_shop == "") {
      final checkIndex = await db!.rawQuery(
          'SELECT * FROM user_setting WHERE key = "shop_id_select" LIMIT 1');
      if (checkIndex.length > 0) {
        Sqflite.current_shop = checkIndex[0]["value"];
        return checkIndex[0]["value"];
      }
      return null;
    }
    return Sqflite.current_shop;
  }

  static Future<String> pickShop(String id) async {
    await db!.rawUpdate(
        'UPDATE user_setting SET value = ? WHERE key = "shop_id_select"', [id]);
    Sqflite.current_shop = id;
    return id;
  }

  static Future<List<ShopModel>?> getListShop() async {
    final checkIndex = await db!
        .rawQuery('SELECT * FROM user_setting WHERE key = "shop_list"');
    if (checkIndex.length > 0) {
      final shops = json.decode(checkIndex[0]["value"]).toList();

      return (shops as List).map((obj) {
        return ShopModel.fromJson(obj);
      }).toList();
    }
    return null;
  }

  static Future<ShopModel?> getCurrentShop() async {
    final checkIndex = await db!
        .rawQuery('SELECT * FROM user_setting WHERE key = "shop_list"');
    if (checkIndex.length > 0) {
      final shops = json.decode(checkIndex[0]["value"]).toList();
      final shopID = await Sqflite.currentShop();
      return (shops as List)
          .map((obj) {
            return ShopModel.fromJson(obj);
          })
          .toList()
          .firstWhere((f) => f.id == shopID);
    }
    return null;
  }

  static Future<ShopModel?> updateCurrentShop(
      {List<ShopModel>? shops, int indexSelected = 0}) async {
    if (shops!.length > 0) {
      final checkIndex = await db!.rawQuery(
          'SELECT * FROM user_setting WHERE key = "shop_id_select" LIMIT 1');

      if (checkIndex.length == 0) {
        await db!.transaction((txn) async {
          await txn.rawInsert(
              'INSERT INTO user_setting(key, value) VALUES("shop_id_select", ?)',
              [shops[0].id]);
          await txn.rawInsert(
              'INSERT INTO user_setting(key, value) VALUES("shop_select_json", ?)',
              [json.encode(shops[0])]);
          await txn.rawInsert(
              'INSERT INTO user_setting(key, value) VALUES("shop_list", ?)',
              [json.encode(shops)]);
          Sqflite.current_shop = shops[0].id!;
        });
      } else {
        //Get select with id
        final shop = shops.firstWhere((l) => l.id == checkIndex[0]["value"]);

        await db!.rawUpdate(
            'UPDATE user_setting SET value = ? WHERE key = "shop_select_json"',
            [json.encode(shop.toJson())]);

        await db!.rawUpdate(
            'UPDATE user_setting SET value = ? WHERE key = "shop_list"',
            [json.encode(shops)]);

        await Sqflite.currentShop();

        return shop;
      }

      return shops.first;
    }
  }

  static String getParamsPath(Map<String, dynamic> queryParameters) {
    String params = '';

    final temp = <dynamic>[];

    queryParameters.entries.forEach((e) {
      if (e.value != null && e.value.toString().isNotEmpty)
        temp.add([e.key, e.value.toString()]);
    });

    if (temp.isNotEmpty) {
      params = '?';

      temp.forEach(
          (e) => params += '${e.first}=${e.last}${e == temp.last ? '' : '&'}');
    }

    return params;
  }
}
