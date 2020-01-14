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
  String toString() => 'ShopGetDetail { id: $id }';
}

class SaveButtonPressed extends ShopEvent {
  final String description;

  SaveButtonPressed({
    this.description,
  }) : super([description]);

  @override
  String toString() => 'SaveButtonPressed { description: $description }';
}
