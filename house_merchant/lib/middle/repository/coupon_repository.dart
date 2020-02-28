import 'dart:io';

import 'package:house_merchant/constant/api_constant.dart';
import 'package:house_merchant/middle/api/coupon_api.dart';
import 'package:house_merchant/middle/model/coupon_model.dart';
import 'package:house_merchant/middle/model/coupon_user_model.dart';
import 'package:house_merchant/middle/model/image_meta_model.dart';
import 'package:house_merchant/middle/model/qrcode_model.dart';

class CouponRepository {
  final couponAPI = new CouponAPI();

  CouponRepository();

  Future<List<CouponModel>> getCoupons(
      {int offset = 1,
      int limit = APIConstant.limitDefault,
      int status = -1}) async {
    final rs = await couponAPI.getCoupons(offset, limit: limit, status: status);
    print('[getCoupons] status = $status, result = $rs');
    return rs;
  }

  Future<QrCodeModel> checkQR(String id, String code) async {
    try {
      final rs = await couponAPI.checkQR(id: id, code: code);
      print(rs);
      if (rs != null) {
        return rs;
      }
      return null;
    } catch (e) {
      return throw (e.toString());
    }
  }

  Future<QrCodeModel> confirmCode(String id, String code) async {
    try {
      final rs = await couponAPI.confirmQR(id: id, code: code);
      print(rs);
      if (rs != null) {
        return rs;
      }
      return null;
    } catch (e) {
      return throw (e.toString());
    }
  }

  Future<CouponModel> createCoupon(CouponModel couponModel) async {
    try {
      final rs = await couponAPI.createCoupon(couponModel);
      if (rs != null) {
        return rs;
      }
      return null;
    } catch (e) {
      return throw (e.toString());
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

  Future<List<CouponUserModel>> getCouponUserList(
      {String id, int offset = 0, int limit = APIConstant.limitDefault}) async {
    final rs = await couponAPI.getCouponUsers(id, limit: limit, offset: offset);
    print('[getCouponUserList] ID = $id, result = $rs');
    return rs;
  }

  Future<CouponModel> updateCoupon(String id, CouponModel couponModel) async {
    final rs = await couponAPI.updateCoupon(id, couponModel);
    print('[updateCoupon] ID = $id, result = ${rs.toString()}');
    return rs;
  }
}
