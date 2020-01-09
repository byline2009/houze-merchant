
import 'package:house_merchant/middle/api/shop_api.dart';
import 'package:house_merchant/middle/model/shop_model.dart';

class ShopRepository {

  final shopAPI = new ShopAPI();

  Future<List<ShopModel>> getShops({int page=1}) async {
    final rs = await shopAPI.getShops(page: page);
    return rs;
  }
}