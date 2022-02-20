import 'package:house_merchant/middle/model/profile_model.dart';

class CouponUserModel {
  String? id;
  ProfileModel? customer;
  String? created;
  String? modified;

  CouponUserModel({
    this.id,
    this.customer,
    this.created,
    this.modified,
  });

  CouponUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer = ProfileModel.fromJson(json["customer"]);
    created = json["created"];
    modified = json["modified"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data["customer"] = this.customer;
    data["created"] = this.created;
    data["modified"] = this.modified;
    return data;
  }
}
