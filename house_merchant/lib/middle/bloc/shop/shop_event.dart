import 'package:equatable/equatable.dart';
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
  String toString() =>
      'ShopGetDetail { id: $id }';
}