import 'package:house_merchant/middle/model/image_meta_model.dart';
import 'package:house_merchant/middle/model/shop_model.dart';

class CouponModel {
  String title;
  int quantity;
  String description;
  String startDate;
  String endDate;
  List<ImageUploadModel> images;
  List<ShopModel> shops;

  CouponModel(
    {this.title,
    this.quantity,
    this.description,
    this.startDate,
    this.endDate,
    this.images,
    this.shops});

  CouponModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    quantity = json['quantity'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    if (json['images'] != null) {
      images = new List<ImageUploadModel>();
      json['images'].forEach((v) {
        images.add(new ImageUploadModel.fromJson(v));
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
    data['title'] = this.title;
    data['quantity'] = this.quantity;
    data['description'] = this.description;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    if (this.shops != null) {
      data['shops'] = this.shops.map((v) => v.toJson()).toList();
    }
    return data;
  }
}