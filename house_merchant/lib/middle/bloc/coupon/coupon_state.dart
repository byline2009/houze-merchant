import 'package:equatable/equatable.dart';
import 'package:house_merchant/middle/model/coupon_model.dart';
import 'package:house_merchant/middle/model/coupon_user_model.dart';
import 'package:house_merchant/middle/model/qrcode_model.dart';
import 'package:meta/meta.dart';

abstract class CouponState extends Equatable {
  List<Object> get props => [];
}

class CouponGetUserListSuccessful extends CouponState {
  final List<CouponUserModel> result;

  CouponGetUserListSuccessful({required this.result});

  @override
  String toString() => 'CouponGetUserListSuccessful { result: $result }';
}

class CouponGetListSuccessful extends CouponState {
  final List<CouponModel> result;

  CouponGetListSuccessful({required this.result});

  @override
  String toString() => 'ShopGetDetailSuccessful { result: $result }';
}

class CouponUpdateSuccessful extends CouponState {
  final CouponModel result;

  CouponUpdateSuccessful({required this.result});

  @override
  String toString() => 'CouponUpdateSuccessful { result: $result }';
}

class CouponGetDetailSuccessful extends CouponState {
  final CouponModel result;

  CouponGetDetailSuccessful({required this.result});

  @override
  String toString() => 'CouponUpdateSuccessful { result: $result }';
}

class CouponScanQRCodeSuccessful extends CouponState {
  final QrCodeModel result;

  CouponScanQRCodeSuccessful({required this.result});

  @override
  String toString() => 'CouponScanQRCodeSuccessful { result: $result }';
}

class CouponInitial extends CouponState {
  @override
  String toString() => 'CouponInitial';
}

class CouponLoading extends CouponState {
  @override
  String toString() => 'CouponLoading';
}

class CouponFailure extends CouponState {
  final String error;

  CouponFailure({required this.error});

  @override
  String toString() => 'CouponFailure { error: $error }';
}
