import 'package:equatable/equatable.dart';

abstract class CouponEvent extends Equatable {
  CouponEvent([List props = const []]) : super(props);
}

class CouponLoadList extends CouponEvent {
  int page;
  int status;

  CouponLoadList({this.page, this.status=-1}) : super([page,status]);

  @override
  String toString() => 'CouponLoadList { page: $page, status: $status }';
}
