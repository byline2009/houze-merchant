import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:house_merchant/middle/model/coupon_model.dart';

abstract class CouponEvent extends Equatable {
  CouponEvent([List props = const []]) : super(props);
}

class CouponLoadList extends CouponEvent {
  int page;
  int status;

  CouponLoadList({this.page, this.status = -1}) : super([page, status]);

  @override
  String toString() => 'CouponLoadList { page: $page, status: $status }';
}

class CouponUserLoadList extends CouponEvent {
  String id;

  CouponUserLoadList({this.id}) : super([id]);

  @override
  String toString() => 'CouponUserLoadList { id: $id}';
}

class SaveButtonPressed extends CouponEvent {
  final CouponModel couponModel;
  final String id;

  SaveButtonPressed({
    @required this.id,
    @required this.couponModel,
  }) : super([id, couponModel]);

  @override
  String toString() =>
      'SaveButtonPressed { id: $id, couponModel: ${couponModel.toJson().toString()} }';
}

class CouponGetDetail extends CouponEvent {
  final String id;

  CouponGetDetail({
    @required this.id,
  }) : super();

  @override
  String toString() => 'CouponGetDetail { id: $id }';
}
