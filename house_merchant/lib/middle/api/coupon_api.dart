import 'dart:io';

import 'package:dio/dio.dart';
import 'package:house_merchant/constant/api_constant.dart';
import 'package:house_merchant/middle/api/oauth_api.dart';
import 'package:house_merchant/middle/model/coupon_model.dart';
import 'package:house_merchant/middle/model/image_meta_model.dart';
import 'package:house_merchant/middle/model/shop_model.dart';
import 'package:house_merchant/utils/sqflite.dart';

class CouponAPI extends OauthAPI {

  CouponAPI() : super();

  Future<CouponModel> createCoupon(CouponModel couponModel) async {

    String currentShop = await Sqflite.currentShop();

    couponModel.shops = [
      ShopModel(id: currentShop)
    ];

    final response = await this.post(
      "${APIConstant.baseMerchantUrlCoupon}",
      data: couponModel
    );

    return CouponModel.fromJson(response.data);
  }

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