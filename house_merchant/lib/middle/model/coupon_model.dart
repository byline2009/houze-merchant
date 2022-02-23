import 'package:flutter/material.dart';
import 'package:house_merchant/constant/common_constant.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/middle/model/image_meta_model.dart';
import 'package:house_merchant/middle/model/shop_model.dart';
import 'package:intl/intl.dart';

class CouponModel {
  String? id;
  String? title;
  int? quantity;
  int? count;
  String? description;
  String? startDate;
  String? endDate;
  int? status;
  int? usedCount;
  List<ImageModel>? images = [];
  List<ShopModel>? shops = [];
  bool? isExpired;

  CouponModel({
    this.id,
    this.title,
    this.quantity,
    this.description,
    this.count,
    this.startDate,
    this.endDate,
    this.status,
    this.images,
    this.shops,
    this.isExpired,
    this.usedCount,
  });

  CouponModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json['title'];
    quantity = json['quantity'];
    count = json["count"];
    usedCount = json["used_count"];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    if (json['images'] != null) {
      images = <ImageModel>[];
      json['images'].forEach((v) {
        images!.add(new ImageModel.fromJson(v));
      });
    }
    if (json['shops'] != null) {
      shops = <ShopModel>[];
      json['shops'].forEach((v) {
        shops!.add(new ShopModel.fromJson(v));
      });
    }
    isExpired = json['is_expired'];
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
    data['count'] = this.count;
    data['used_count'] = this.usedCount;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.shops != null) {
      data['shops'] = this.shops!.map((v) => v.toJson()).toList();
    }
    data['is_expired'] = this.isExpired;
    return data;
  }

  String startDateLocal({String? start}) {
    return DateFormat(Format.timeAndDate)
        .format(DateTime.parse(start!).toLocal())
        .toString();
  }

  String endDateLocal({String? end}) {
    return DateFormat(Format.timeAndDate)
        .format(DateTime.parse(end!).toLocal())
        .toString();
  }

  String startDateUTC() {
    return DateFormat(Format.timeAndDate)
        .format(DateTime.parse(startDate!).toLocal())
        .toString();
  }

  String endDateUTC() {
    return DateFormat(Format.timeAndDate)
        .format(DateTime.parse(endDate!).toUtc())
        .toString();
  }

  String fullDate(String start, String end) {
    return startDateLocal(start: start) + ' đến ' + endDateLocal(end: end);
  }

  String statusName() {
    if (this.isExpired == true) {
      return Promotion.expire;
    }
    switch (this.status) {
      case Promotion.pendingStatus:
        return Promotion.pending;

      case Promotion.approveStatus:
        return Promotion.approved;

      case Promotion.rejectStatus:
        return Promotion.rejected;

      case Promotion.canceledStatus:
        return Promotion.canceled;

      default:
        return '';
    }
  }

  Color statusColor() {
    if (this.isExpired == true) {
      return ThemeConstant.status_canceled;
    }
    switch (this.status) {
      case Promotion.pendingStatus:
        return ThemeConstant.pending_color;

      case Promotion.approveStatus:
        return ThemeConstant.approved_color;

      case Promotion.rejectStatus:
        return ThemeConstant.status_rejected;

      case Promotion.canceledStatus:
        return ThemeConstant.status_cancel;

      default:
        return ThemeConstant.black_color;
    }
  }

  String getNumberOfUsersUsed() {
    return '$usedCount/$quantity';
  }
}

//** COUPON LIST **//
class CouponList {
  int? response;
  int? page;
  List<CouponModel>? data;

  CouponList({this.response, this.data, this.page});

  CouponList.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    if (json['data'] != null) {
      data = <CouponModel>[];
      json['data'].forEach((v) {
        data!.add(new CouponModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
