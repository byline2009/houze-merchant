import 'package:equatable/equatable.dart';
import 'package:house_merchant/middle/model/qrcode_model.dart';
import 'package:meta/meta.dart';

abstract class CouponEvent extends Equatable {
  CouponEvent([List props = const []]) : super(props);
}

class CouponLoadList extends CouponEvent {
  int page;
  int status;

  CouponLoadList({this.page, this.status = -1}) : super([page, status]);

  @override
  String toString() => 'CouponLoadList { page: $page, status: $status }';
}

class ScanQRButtonPressed extends CouponEvent {
  final String id;
  final String code;

  ScanQRButtonPressed({
    @required this.id,
    @required this.code,
  }) : super([id, code]);

  @override
  String toString() => 'CouponScanQRCodeEvent { id: $id, code: $code}';
}

class ConfirmQRCodeButtonPressed extends CouponEvent {
  final QrCodeModel qrCodeModel;

  ConfirmQRCodeButtonPressed({
    this.qrCodeModel,
  }) : super([qrCodeModel]);

  @override
  String toString() =>
      'ConfirmQRCodeButtonPressed { qrCodeModel: $qrCodeModel }';
}
