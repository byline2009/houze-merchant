import 'package:house_merchant/middle/model/image_meta_model.dart';

class ShopModel {
  String id;
  String name;
  String description;
  int status;
  double lat;
  double long;
  List<dynamic> images = List<dynamic>();

  ShopModel(
    {this.id,
    this.name,
    this.description,
    this.status,
    this.lat,
    this.long,
    this.images});

  ShopModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    lat = json['lat'];
    long = json['long'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['status'] = this.status;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['images'] = this.images;
    return data;
  }
}