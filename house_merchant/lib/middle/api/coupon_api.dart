import 'package:house_merchant/constant/api_constant.dart';
import 'package:house_merchant/middle/api/oauth_api.dart';
import 'package:house_merchant/middle/model/coupon_model.dart';

class CouponAPI extends OauthAPI {

  CouponAPI() : super();

  Future<CouponModel> createCoupon(CouponModel couponModel) async {

    final response = await this.post(
      "${APIConstant.baseMerchantUrlCoupon}",
      data: couponModel
    );

    return CouponModel.fromJson(response.data);
  }

}