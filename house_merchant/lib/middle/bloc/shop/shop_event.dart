import 'package:equatable/equatable.dart';
import 'package:house_merchant/middle/model/shop_model.dart';
import 'package:meta/meta.dart';

abstract class ShopEvent extends Equatable {
  ShopEvent([List props = const []]) : super(props);
}

class ShopGetDetail extends ShopEvent {
  final String id;

  ShopGetDetail({
    @required this.id,
  }) : super();

  @override
  String toString() => 'ShopGetDetail { id: $id }';
}

class SaveButtonPressed extends ShopEvent {
  final ShopModel shopModel;

  SaveButtonPressed({
    this.shopModel,
  }) : super([shopModel]);

  @override
  String toString() => 'SaveButtonPressed { shopModel: $shopModel }';
}
