import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:house_merchant/middle/model/shop_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Sqflite {

  static Database db;
  static const int version = 1;
  static const String database_name = "shop.db";
  static String current_shop = "";

  static Future init() async {

    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, database_name);

    try {
      debugPrint("Sqflite init in path: ${path}");
      db = await openDatabase(path, version: version,
        onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute('CREATE TABLE IF NOT EXISTS user_setting (key TEXT, value TEXT)');
      });
    } catch (e) {
      print("Error $e");
    }
    
  }

  static Future flush() async {
    await db.rawUpdate('DELETE FROM user_setting');
  }

  static Future<String> currentShop() async {
    if (Sqflite.current_shop == "") {
      final check_index = await db.rawQuery('SELECT * FROM user_setting WHERE key = "shop_id_select" LIMIT 1');
      if (check_index.length > 0) {
        Sqflite.current_shop = check_index[0]["value"];
        return check_index[0]["value"];
      }
      return null;
    }
    return Sqflite.current_shop;
  }

  static Future<String> pickShop(String id) async {
    await db.rawUpdate(
      'UPDATE user_setting SET value = ? WHERE key = "shop_id_select"',
      [id]);
    Sqflite.current_shop = id;
    return id;
  }

  static Future<List<ShopModel>> getListShop() async {
    final check_index = await db.rawQuery('SELECT * FROM user_setting WHERE key = "shop_list"');
    if (check_index.length > 0) {

      final shops = json.decode(check_index[0]["value"]).toList();

      return (shops as List).map((obj) {
        return ShopModel.fromJson(obj);
      }).toList();
    }
    return null;
  }

  static Future<ShopModel> getCurrentShop() async {
    final check_index = await db.rawQuery('SELECT * FROM user_setting WHERE key = "shop_list"');
    if (check_index.length > 0) {
      final shops = json.decode(check_index[0]["value"]).toList();
      final shop_id = await Sqflite.currentShop();
      return (shops as List).map((obj) {
        return ShopModel.fromJson(obj);
      }).toList().firstWhere((f) => f.id==shop_id);
    }
    return null;
  }

  static Future<ShopModel> updateCurrentShop({List<ShopModel> shops, int indexSelected = 0}) async {
    if (shops.length > 0) {

      final check_index = await db.rawQuery('SELECT * FROM user_setting WHERE key = "shop_id_select" LIMIT 1');

      if (check_index.length == 0) {
        await db.transaction((txn) async {
          await txn.rawInsert(
              'INSERT INTO user_setting(key, value) VALUES("shop_id_select", ?)',
              [ shops[0].id ]);
          await txn.rawInsert(
              'INSERT INTO user_setting(key, value) VALUES("shop_select_json", ?)',
              [ json.encode(shops[0])]);
          await txn.rawInsert(
              'INSERT INTO user_setting(key, value) VALUES("shop_list", ?)',
              [ json.encode(shops)]);
          Sqflite.current_shop = shops[0].id;
        });
      } else {
        
        //Get select with id
        final shop = shops.firstWhere((l) => l.id == check_index[0]["value"]);

        await db.rawUpdate(
          'UPDATE user_setting SET value = ? WHERE key = "shop_select_json"',
          [json.encode(shop.toJson())]);

        await db.rawUpdate(
          'UPDATE user_setting SET value = ? WHERE key = "shop_list"',
          [json.encode(shops)]);

        await Sqflite.currentShop();

        return shop;

      }

      return shops[0];

    }
  }
  
}