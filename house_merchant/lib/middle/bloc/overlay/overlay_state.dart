import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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