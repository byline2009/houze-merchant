import 'dart:io';

import 'package:dio/dio.dart';
import 'package:house_merchant/constant/api_constant.dart';
import 'package:house_merchant/middle/api/oauth_api.dart';
import 'package:house_merchant/middle/model/base_model.dart';
import 'package:house_merchant/middle/model/coupon_model.dart';
import 'package:house_merchant/middle/model/image_meta_model.dart';
import 'package:house_merchant/middle/model/shop_model.dart';
import 'package:house_merchant/utils/sqflite.dart';

class CouponAPI extends OauthAPI {
  CouponAPI() : super();

  //MARK: Get coupons
  Future<List<CouponModel>> getCoupons(int page, {int limit = 10}) async {
    final response =
        await this.get(APIConstant.baseMerchantUrlCoupon, queryParameters: {
      "offset": (page - 1) * limit,
      "limit": limit,
    });

    print({
      "offset": (page - 1) * limit,
      "limit": limit,
    });

    return (PageModel.map(response.data).results as List).map((i) {
      return CouponModel.fromJson(i);
    }).toList();
  }

  //MARK: Create coupon
  Future<CouponModel> createCoupon(CouponModel couponModel) async {
    String currentShop = await Sqflite.currentShop();

    couponModel.shops = [ShopModel(id: currentShop)];

    final response = await this
        .post("${APIConstant.baseMerchantUrlCoupon}", data: couponModel);

    return CouponModel.fromJson(response.data);
  }

  //MARK: Upload image
  Future<dynamic> uploadImage(File image) async {
    try {
      FormData formData =
          new FormData.from({"image": new UploadFileInfo(image, "ticket.jpg")});

      final String url = APIConstant.baseMerchantUrlCouponUpload;

      final response = await this.post(
        url,
        data: formData,
      );

      final rs = ImageModel.fromJson(response.data);
      return rs;
    } on DioError catch (e) {
      print(e);
      return throw e;
    }
  }
}
