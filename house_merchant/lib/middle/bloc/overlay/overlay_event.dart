import 'package:equatable/equatable.dart';

abstract class OverlayEvent extends Equatable {
  OverlayEvent([List props = const []]) : super(props);
}

class ShopPicked extends OverlayEvent {

  ShopPicked() : super([]);

}