import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_merchant/middle/bloc/coupon/indext.dart';
import 'package:house_merchant/middle/repository/coupon_repository.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  CouponRepository couponRepository = CouponRepository();

  CouponBloc();

  CouponState get initialState => CouponInitial();

  @override
  Stream<CouponState> mapEventToState(CouponEvent event) {
    // TODO: implement mapEventToState
    return null;
  }
}
