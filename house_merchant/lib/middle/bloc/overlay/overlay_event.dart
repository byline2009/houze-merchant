import 'package:equatable/equatable.dart';

abstract class OverlayBlocEvent extends Equatable {
  List<Object> get props => [];
}

class ShopPicked extends OverlayBlocEvent {
  ShopPicked();
}
