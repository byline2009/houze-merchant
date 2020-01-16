import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:house_merchant/middle/model/coupon_model.dart';
import 'package:house_merchant/middle/model/shop_model.dart';

abstract class OverlayBlocState extends Equatable {
  OverlayBlocState([List props = const []]) : super(props);
}

class ShopInitial extends OverlayBlocState {
  @override
  String toString() => 'ShopInitial';
}

class ShopSuccessful extends OverlayBlocState {
  final List<ShopModel> result;
  final ShopModel shop;

  ShopSuccessful({@required this.result, this.shop});

  @override
  String toString() => 'ShopSuccessful { result: $result, shop_select: $shop }';
}

class ShopLoading extends OverlayBlocState {
  @override
  String toString() => 'ShopLoading';
}

class ShopChanged extends OverlayBlocState {
  @override
  String toString() => 'ShopChanged';
}

class ShopFailure extends OverlayBlocState {
  final String error;

  ShopFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'ShopFailure { error: $error }';
}

//MARK: Coupon
class CouponInitial extends OverlayBlocState {
  @override
  String toString() => 'CouponInitial';
}

class CouponSuccessful extends OverlayBlocState {
  final List<CouponModel> result;
  final CouponModel coupon;

  CouponSuccessful({@required this.result, this.coupon});

  @override
  String toString() =>
      'CouponSuccessful { result: $result, coupon_select: $coupon }';
}

class CouponLoading extends OverlayBlocState {
  @override
  String toString() => 'CouponLoading';
}

class CouponChanged extends OverlayBlocState {
  @override
  String toString() => 'CouponChanged';
}

class CouponFailure extends OverlayBlocState {
  final String error;

  CouponFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'CouponFailure { error: $error }';
}
