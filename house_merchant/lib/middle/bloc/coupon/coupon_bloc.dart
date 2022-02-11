import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_merchant/middle/bloc/coupon/indext.dart';
import 'package:house_merchant/middle/repository/coupon_repository.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  CouponRepository couponRepository = CouponRepository();

  CouponBloc(CouponState initialState) : super(initialState) {
    on<CouponUserLoadList>((event, emit) async {
      emit(CouponLoading());

      try {
        final result = await couponRepository.getCouponUserList(
            id: event.id, page: event.page);
        emit(CouponGetUserListSuccessful(result: result));
      } catch (error) {
        emit(CouponFailure(error: error.toString()));
      }
    });
    on<CouponLoadList>((event, emit) async {
      emit(CouponLoading());

      try {
        final result = await couponRepository.getCoupons();
        emit(CouponGetListSuccessful(result: result));
      } catch (error) {
        emit(CouponFailure(error: error.toString()));
      }
    });
    on<SaveButtonPressed>((event, emit) async {
      emit(CouponLoading());

      try {
        final result =
            await couponRepository.updateCoupon(event.id, event.couponModel);
        print(result.toJson().toString());
        emit(CouponUpdateSuccessful(result: result));
      } catch (error) {
        emit(CouponFailure(error: error.toString()));
      }
    });
    on<CouponGetDetail>((event, emit) async {
      try {
        final result = await couponRepository.getCoupon(event.id);
        emit(CouponGetDetailSuccessful(result: result));
      } catch (error) {
        emit(CouponFailure(error: error.toString()));
      }
    });
  }
  // CouponState get initialState => CouponInitial();

  // @override
  // Stream<CouponState> mapEventToState(CouponEvent event) async* {
  //   if (event is CouponUserLoadList) {
  //     yield CouponLoading();

  //     try {
  //       final result = await couponRepository.getCouponUserList(
  //           id: event.id, page: event.page);
  //       yield CouponGetUserListSuccessful(result: result);
  //     } catch (error) {
  //       yield CouponFailure(error: error.toString());
  //     }
  //   }

  //   if (event is CouponLoadList) {
  //     yield CouponLoading();

  //     try {
  //       final result = await couponRepository.getCoupons();
  //       yield CouponGetListSuccessful(result: result);
  //     } catch (error) {
  //       yield CouponFailure(error: error.toString());
  //     }
  //   }

  //   if (event is SaveButtonPressed) {
  //     yield CouponLoading();

  //     try {
  //       final result =
  //           await couponRepository.updateCoupon(event.id, event.couponModel);
  //       print(result.toJson().toString());
  //       yield CouponUpdateSuccessful(result: result);
  //     } catch (error) {
  //       yield CouponFailure(error: error.toString());
  //     }
  //   }

  //   if (event is CouponGetDetail) {
  //     try {
  //       final result = await couponRepository.getCoupon(event.id);
  //       yield CouponGetDetailSuccessful(result: result);
  //     } catch (error) {
  //       yield CouponFailure(error: error.toString());
  //     }
  //   }
  // }
}
