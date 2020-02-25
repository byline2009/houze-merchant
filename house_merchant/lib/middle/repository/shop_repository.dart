
import 'package:house_merchant/middle/api/shop_api.dart';
import 'package:house_merchant/middle/model/image_meta_model.dart';
import 'package:house_merchant/middle/model/shop_model.dart';
import 'package:house_merchant/utils/sqflite.dart';

class ShopRepository {
  final shopAPI = new ShopAPI();

  Future<List<ShopModel>> getShops({int page = 1}) async {
    final rs = await shopAPI.getShops(page: page);
    return rs;
  }

  Future<ShopModel> getShop(String id) async {
    final rs = await shopAPI.getShop(id);
    return rs;
  }

  Future<ShopModel> updateImages(String id, List<ImageModel> images) async {
    final rs = await shopAPI.updateImages(id, images);
    return rs;
  }

  Future<ShopModel> updateInfo(ShopModel shopModel) async {
    final String currentShop = await Sqflite.currentShop();
    final rs = await shopAPI.updateInfo(currentShop, shopModel);
    return rs;
  }
}