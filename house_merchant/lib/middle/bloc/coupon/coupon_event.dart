import 'package:equatable/equatable.dart';

abstract class CouponEvent extends Equatable {
  CouponEvent([List props = const []]) : super(props);
}

class CouponLoadList extends CouponEvent {
  int page;

  CouponLoadList({this.page}) : super([page]);

  @override
  String toString() => 'CouponLoadList { page: $page }';
}
