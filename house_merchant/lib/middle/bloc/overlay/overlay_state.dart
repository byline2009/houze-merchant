import 'package:equatable/equatable.dart';

abstract class OverlayState extends Equatable {
  OverlayState([List props = const []]) : super(props);
}

class ShopInitial extends OverlayState {
  @override
  String toString() => 'ShopInitial';
}