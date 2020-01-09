import 'package:equatable/equatable.dart';

abstract class OverlayBlocEvent extends Equatable {
  OverlayBlocEvent([List props = const []]) : super(props);
}

class ShopPicked extends OverlayBlocEvent {

  ShopPicked() : super([]);

}