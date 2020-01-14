
import 'dart:io';

import 'package:house_merchant/middle/api/coupon_api.dart';
import 'package:house_merchant/middle/model/coupon_model.dart';
import 'package:house_merchant/middle/model/image_meta_model.dart';

class CouponRepository {

  final couponAPI = new CouponAPI();

  CouponRepository();

  Future<CouponModel> createCoupon(CouponModel couponModel) async {
    try {

      final rs = await couponAPI.createCoupon(couponModel);
      if (rs != null) {
        return rs;
      }
      return null;

    } catch (e) {
      return throw(e.toString());
    }
    
  }

   Future<ImageModel> uploadImage(File file) async {
    //Call Dio API
    final rs = await couponAPI.uploadImage(file);
    if (rs != null) {
      return rs;
    }
    return null;
  }
}