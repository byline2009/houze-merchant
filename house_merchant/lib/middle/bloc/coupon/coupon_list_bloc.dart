import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_merchant/constant/api_constant.dart';
import 'package:house_merchant/middle/bloc/coupon/indext.dart';
import 'package:house_merchant/middle/model/coupon_model.dart';
import 'package:house_merchant/middle/repository/coupon_repository.dart';

class CouponListBloc extends Bloc<CouponEvent, CouponList> {
  int page = 1;
  List<CouponModel> result = <CouponModel>[];
  bool isNext = true;
  int offset = 0;

  CouponRepository couponRepository = CouponRepository();

  CouponListBloc(CouponList initialState) : super(initialState) {
    on<CouponLoadList>((event, emit) async {
      if (event.page != null) {
        this.page = event.page;
      }

      //first init
      if (event.page == 0) {
        emit(CouponList(
          data: result,
          response: 0,
        ));
        return;
      }

      var currentOffset = (this.page * APIConstant.limitDefault) + this.offset;
      if (result.length <= APIConstant.limitDefault) {
        currentOffset = result.length;
      }

      //for refresh drag
      if (event.page == -1) {
        currentOffset = offset = this.page = 0;
        this.result = [];
      }

      var _results = await couponRepository.getCoupons(
          offset: currentOffset,
          limit: APIConstant.limitDefault,
          status: event.status);

      //If empty
      if (_results.length == 0) {
        this.isNext = false;
      } else {
        this.isNext = true;
      }

      if (_results.length > 0) {
        this.page++;
      }

      _results.insertAll(0, this.result);
      result = _results;

      emit(CouponList(
        data: _results,
        response: 0,
      ));
    });
  }

  // @override
  // CouponList get initialState => CouponList(
  //       data: result,
  //       response: 1,
  //     );

  // @override
  // Stream<CouponList> mapEventToState(CouponEvent event) async* {
  //   if (event is CouponLoadList) {
  //     if (event.page != null) {
  //       this.page = event.page;
  //     }

  //     //first init
  //     if (event.page == 0) {
  //       yield CouponList(
  //         data: result,
  //         response: 0,
  //       );
  //       return;
  //     }

  //     var currentOffset = (this.page * APIConstant.limitDefault) + this.offset;
  //     if (result.length <= APIConstant.limitDefault) {
  //       currentOffset = result.length;
  //     }

  //     //for refresh drag
  //     if (event.page == -1) {
  //       currentOffset = offset = this.page = 0;
  //       this.result = [];
  //     }

  //     var _results = await couponRepository.getCoupons(
  //         offset: currentOffset,
  //         limit: APIConstant.limitDefault,
  //         status: event.status);

  //     //If empty
  //     if (_results.length == 0) {
  //       this.isNext = false;
  //     } else {
  //       this.isNext = true;
  //     }

  //     if (_results.length > 0) {
  //       this.page++;
  //     }

  //     _results.insertAll(0, this.result);
  //     result = _results;

  //     yield CouponList(
  //       data: _results,
  //       response: 0,
  //     );
  //   }
  // }
}
