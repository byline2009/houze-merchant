import 'package:equatable/equatable.dart';
import 'package:house_merchant/middle/model/shop_model.dart';
import 'package:meta/meta.dart';

abstract class ShopState extends Equatable {
  ShopState([List props = const []]) : super(props);
}

class ShopInitial extends ShopState {
  @override
  String toString() => 'ShopInitial';
}

class ShopGetDetailSuccessful extends ShopState {

  final ShopModel result;

  ShopGetDetailSuccessful({@required this.result});

  @override
  String toString() => 'ShopGetDetailSuccessful { result: $result }';
}

class ShopLoading extends ShopState {
  @override
  String toString() => 'ShopLoading';
}

class ShopSuccessful extends ShopState {
  @override
  String toString() => 'ShopSuccessful';
}

class ShopFailure extends ShopState {
  final String error;

  ShopFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'ShopFailure { error: $error }';
}