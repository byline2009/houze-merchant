import 'package:house_merchant/middle/model/image_meta_model.dart';

class ShopModel {
  String id;
  String name;
  String description;
  int status;
  double lat;
  double long;

  List<dynamic> images = List<dynamic>();
  List<dynamic> hours = List<dynamic>();

  ShopModel({
    this.id,
    this.name,
    this.description,
    this.status,
    this.lat,
    this.long,
    this.images,
    this.hours,
  });

  ShopModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    lat = json['lat'];
    long = json['long'];

    if (json['images'] != null) {
      images = new List<ImageModel>();
      json['images'].forEach((v) {
        images.add(new ImageModel.fromJson(v));
      });
    }
    hours = json['hours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['status'] = this.status;
    data['lat'] = this.lat;
    data['long'] = this.long;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    return data;
  }

  String getStatusName() {
    return status == 0 ? 'Đang hoạt động' : 'Chưa hoạt động';
  }
}

class ImageDeleteRequest {
  List<String> listId;

  ImageDeleteRequest({this.listId});

  ImageDeleteRequest.fromJson(Map<String, dynamic> json) {
    listId = json['list_id'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['list_id'] = this.listId;

    return data;
  }
}
