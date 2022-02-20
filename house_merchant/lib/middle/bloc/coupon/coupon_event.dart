import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:house_merchant/middle/model/coupon_model.dart';

abstract class CouponEvent extends Equatable {
  List<Object> get props => [];
}

class CouponLoadList extends CouponEvent {
  final int page;
  final int status;

  CouponLoadList({required this.page, this.status = -1});

  @override
  String toString() => 'CouponLoadList { page: $page, status: $status }';
}

class CouponUserLoadList extends CouponEvent {
  final String? id;
  final int page;
  CouponUserLoadList({this.id, required this.page});

  @override
  String toString() => 'CouponUserLoadList { id: $id}';
}

class SaveButtonPressed extends CouponEvent {
  final CouponModel couponModel;
  final String id;

  SaveButtonPressed({
    required this.id,
    required this.couponModel,
  });

  @override
  String toString() =>
      'SaveButtonPressed { id: $id, couponModel: ${couponModel.toJson().toString()} }';
}

class CouponGetDetail extends CouponEvent {
  final String id;

  CouponGetDetail({
    required this.id,
  }) : super();

  @override
  String toString() => 'CouponGetDetail { id: $id }';
}
