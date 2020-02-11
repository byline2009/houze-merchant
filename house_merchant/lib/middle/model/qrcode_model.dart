import 'package:house_merchant/middle/model/coupon_model.dart';
import 'package:house_merchant/middle/model/profile_model.dart';

class QrCodeModel {
  String id;
  String code;
  CouponModel coupon;
  ProfileModel customer;
  bool isUsed;

  QrCodeModel({
    this.id,
    this.code,
    this.coupon,
    this.customer,
    this.isUsed,
  });

  QrCodeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json["code"];
    coupon = json["coupon"];
    customer = json["customer"];
    isUsed = json["is_used"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['coupon'] = this.coupon;
    data['customer'] = this.customer;
    data['isUsed'] = this.isUsed;

    return data;
  }
}
