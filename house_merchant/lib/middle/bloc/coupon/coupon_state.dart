import 'package:equatable/equatable.dart';
import 'package:house_merchant/middle/model/coupon_model.dart';
import 'package:meta/meta.dart';

abstract class CouponState extends Equatable {
  CouponState([List props = const []]) : super(props);
}

class CouponGetListSuccessful extends CouponState {
  final List<CouponModel> result;

  CouponGetListSuccessful({@required this.result});

  @override
  String toString() => 'ShopGetDetailSuccessful { result: $result }';
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

  CouponFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'CouponFailure { error: $error }';
}
