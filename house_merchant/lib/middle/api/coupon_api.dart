import 'dart:io';

import 'package:dio/dio.dart';
import 'package:house_merchant/constant/api_constant.dart';
import 'package:house_merchant/constant/common_constant.dart';
import 'package:house_merchant/middle/api/oauth_api.dart';
import 'package:house_merchant/middle/model/base_model.dart';
import 'package:house_merchant/middle/model/coupon_model.dart';
import 'package:house_merchant/middle/model/coupon_user_model.dart';
import 'package:house_merchant/middle/model/image_meta_model.dart';
import 'package:house_merchant/middle/model/qrcode_model.dart';
import 'package:house_merchant/middle/model/shop_model.dart';
import 'package:house_merchant/utils/sqflite.dart';

class CouponAPI extends OauthAPI {
  CouponAPI() : super();
  Dio? dio;

  //MARK: Get coupons
  Future<List<CouponModel>> getCoupons(int offset,
      {int limit = 10, int status = -1}) async {
    final Map<String, dynamic> params = {"offset": offset, "limit": limit};

    if (status > -1) {
      params['status'] = status;
    }
    //get all coupon
    if (status == Promotion.approveStatus) {
      params['is_expired'] = 'false';
    }

    if (status == -2) {
      params['is_expired'] = 'true';
    }

    final response = await this
        .get(APIConstant.baseMerchantUrlCoupon, queryParameters: params);

    return (PageModel.map(response.data).results as List).map((i) {
      return CouponModel.fromJson(i);
    }).toList();
  }

  //MARK: Create coupon
  Future<CouponModel> createCoupon(CouponModel couponModel) async {
    String? currentShop = await Sqflite.currentShop();

    couponModel.shops = [ShopModel(id: currentShop)];

    final response = await this
        .post("${APIConstant.baseMerchantUrlCoupon}", data: couponModel);

    return CouponModel.fromJson(response.data);
  }

  //MARK: Check QR
  Future<QrCodeModel> checkQR({id: String, code: String}) async {
    final response = await this.post(
      '${APIConstant.baseMerchantUrlCoupon}check-qr/',
      data: {"id": id, "code": code},
    );
    return QrCodeModel.fromJson(response.data);
  }

  Future<QrCodeModel> confirmQR({String? id, String? code}) async {
    final response = await this.post(
        '${APIConstant.baseMerchantUrlCoupon}confirm-qr/',
        data: {"id": id, "code": code});
    return QrCodeModel.fromJson(response.data);
  }

  //MARK: Get coupons
  Future<List<CouponUserModel>> getCouponUsers(String? id,
      {int? page, int limit = 10, int? offset}) async {
    final Map<String, dynamic> params = {
      "offset": page! * limit,
      "limit": limit,
    };

    final response = await this.get(
        '${APIConstant.baseMerchantUrlCoupon}coupon-user/$id/',
        queryParameters: params);

    return (PageModel.map(response.data).results as List).map((i) {
      return CouponUserModel.fromJson(i);
    }).toList();
  }

  //MARK: Upload image
  Future<dynamic> uploadImage(File image) async {
    try {
      FormData formData = new FormData.fromMap({
        "image": MultipartFile.fromFileSync(image.path, filename: "ticket.jpg")
      });

      final String? url = APIConstant.baseMerchantUrlCouponUpload;

      final response = await this.post(
        url!,
        data: formData,
      );

      final rs = ImageModel.fromJson(response.data);
      return rs;
    } on DioError catch (e) {
      print(e);
      return throw e;
    }
  }

  Future<CouponModel> updateCoupon(String id, CouponModel data) async {
    try {
      final response = await this
          .patch('${APIConstant.baseMerchantUrlCoupon}update/$id/', data: data);
      return CouponModel.fromJson(response.data);
    } on DioError catch (e) {
      print('[updateCoupon] error $e');
      return throw e;
    }
  }

  Future<CouponModel> getCoupon(String id) async {
    try {
      final response = await this.get(
          "${APIConstant.baseMerchantUrlCoupon}detail/$id/",
          queryParameters: {});

      return CouponModel.fromJson(response.data);
    } on DioError catch (e) {
      print('[updateCoupon] error $e');
      return throw e;
    }
  }
}
