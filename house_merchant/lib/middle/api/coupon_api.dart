import 'package:house_merchant/constant/api_constant.dart';
import 'package:house_merchant/middle/api/oauth_api.dart';
import 'package:house_merchant/middle/model/coupon_model.dart';
import 'package:house_merchant/middle/model/shop_model.dart';

class CouponAPI extends OauthAPI {

  CouponAPI() : super();

  Future<CouponModel> createCoupon(CouponModel couponModel) async {

    couponModel.images = [
    ];

    couponModel.shops = [
      ShopModel(id: "906e9659-61d6-40a3-86e5-a6ec779ae2fe")
    ];

    final response = await this.post(
      "${APIConstant.baseMerchantUrlCoupon}",
      data: couponModel
    );

    return CouponModel.fromJson(response.data);
  }

}