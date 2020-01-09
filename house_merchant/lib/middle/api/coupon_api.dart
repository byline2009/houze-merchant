import 'package:house_merchant/constant/api_constant.dart';
import 'package:house_merchant/middle/api/oauth_api.dart';
import 'package:house_merchant/middle/model/coupon_model.dart';
import 'package:house_merchant/middle/model/shop_model.dart';
import 'package:house_merchant/utils/sqflite.dart';

class CouponAPI extends OauthAPI {

  CouponAPI() : super();

  Future<CouponModel> createCoupon(CouponModel couponModel) async {

    String currentShop = await Sqflite.currentShop();

    couponModel.images = [
    ];

    couponModel.shops = [
      ShopModel(id: currentShop)
    ];

    final response = await this.post(
      "${APIConstant.baseMerchantUrlCoupon}",
      data: couponModel
    );

    return CouponModel.fromJson(response.data);
  }

}