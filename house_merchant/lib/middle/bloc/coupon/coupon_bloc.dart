import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_merchant/middle/bloc/coupon/indext.dart';
import 'package:house_merchant/middle/repository/coupon_repository.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  CouponRepository couponRepository = CouponRepository();

  CouponBloc();
  CouponState get initialState => CouponInitial();

  @override
  Stream<CouponState> mapEventToState(CouponEvent event) async* {
    if (event is CouponUserLoadList) {
      yield CouponLoading();

      try {
        final result = await couponRepository.getCouponUserList(id: event.id);
        yield CouponGetUserListSuccessful(result: result);
      } catch (error) {
        yield CouponFailure(error: error.toString());
      }
    }

    if (event is CouponLoadList) {
      yield CouponLoading();

      try {
        final result = await couponRepository.getCoupons();
        yield CouponGetListSuccessful(result: result);
      } catch (error) {
        yield CouponFailure(error: error.toString());
      }
    }

    if (event is SaveButtonPressed) {
      yield CouponLoading();

      try {
        final result =
            await couponRepository.updateCoupon(event.id, event.couponModel);
        print(result.toJson().toString());
        yield CouponUpdateSuccessful(result: result);
      } catch (error) {
        yield CouponFailure(error: error.toString());
      }
    }

    if (event is CouponGetDetail) {
      try {
        final result = await couponRepository.getCoupon(event.id);
        yield CouponGetDetailSuccessful(result: result);
      } catch (error) {
        yield CouponFailure(error: error.toString());
      }
    }
  }
}
