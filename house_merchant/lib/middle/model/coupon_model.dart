import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/middle/model/image_meta_model.dart';
import 'package:house_merchant/middle/model/shop_model.dart';

class CouponModel {
  String id;
  String title;
  int quantity;
  String description;
  String startDate;
  String endDate;
  int status;
  List<ImageModel> images = List<ImageModel>();
  List<ShopModel> shops = List<ShopModel>();

  CouponModel({
    this.id,
    this.title,
    this.quantity,
    this.description,
    this.startDate,
    this.endDate,
    this.status,
    this.images,
    this.shops,
  });

  CouponModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json['title'];
    quantity = json['quantity'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    if (json['images'] != null) {
      images = new List<ImageModel>();
      json['images'].forEach((v) {
        images.add(new ImageModel.fromJson(v));
      });
    }
    if (json['shops'] != null) {
      shops = new List<ShopModel>();
      json['shops'].forEach((v) {
        shops.add(new ShopModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['quantity'] = this.quantity;
    data['description'] = this.description;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['status'] = this.status;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    if (this.shops != null) {
      data['shops'] = this.shops.map((v) => v.toJson()).toList();
    }
    return data;
  }

  String getStatusName() {
    if (this.status == 0) {
      return ThemeConstant.pending_status;
    }
    if (this.status == 1) {
      return ThemeConstant.ready_status;
    }
    if (this.status == 2) {
      return ThemeConstant.expired_status;
    }
  }
}
