import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_merchant/middle/bloc/coupon/indext.dart';
import 'package:house_merchant/middle/repository/coupon_repository.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  CouponRepository couponRepository = CouponRepository();

  CouponBloc();
  CouponState get initialState => CouponInitial();

  @override
  Stream<CouponState> mapEventToState(CouponEvent event) async* {
    if (event is ConfirmQRCodeButtonPressed) {
      yield CouponLoading();
      final result = await couponRepository.confirmCode(
          event.qrCodeModel.id, event.qrCodeModel.code);
      yield CouponScanQRCodeSuccessful(result: result);
      try {} catch (error) {
        yield CouponFailure(error: error.toString());
      }
    }

    if (event is ScanQRButtonPressed) {
      yield CouponLoading();
      try {
        final result = await couponRepository.scanQRCode(event.id, event.code);
        yield CouponScanQRCodeSuccessful(result: result);
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
  }
}
