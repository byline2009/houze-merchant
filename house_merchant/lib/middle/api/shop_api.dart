
import 'package:house_merchant/constant/api_constant.dart';
import 'package:house_merchant/middle/api/oauth_api.dart';
import 'package:house_merchant/middle/model/base_model.dart';
import 'package:house_merchant/middle/model/shop_model.dart';

class ShopAPI extends OauthAPI {

  ShopAPI() : super();

  Future<List<ShopModel>> getShops({int page=0}) async {

    final response = await this.get(
      APIConstant.baseMerchantUrlShop,
      queryParameters: {}
    );

    return (PageModel.map(response.data).results as List).map((i) {
      return ShopModel.fromJson(i);
    }).toList();
  }

  Future<ShopModel> getShop(String id) async {

    final response = await this.get(
      "${APIConstant.baseMerchantUrlShop}${id}/",
      queryParameters: {}
    );

    return ShopModel.fromJson(response.data);
  }

}