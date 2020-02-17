import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:house_merchant/constant/common_constant.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/button_outline_widget.dart';
import 'package:house_merchant/custom/button_widget.dart';
import 'package:house_merchant/custom/dialogs/T7GDialog.dart';
import 'package:house_merchant/custom/read_more_text_widget.dart';
import 'package:house_merchant/custom/rectangle_label_widget.dart';
import 'package:house_merchant/middle/model/coupon_model.dart';
import 'package:house_merchant/middle/model/qrcode_model.dart';
import 'package:house_merchant/middle/repository/coupon_repository.dart';
import 'package:house_merchant/router.dart';
import 'package:house_merchant/screen/base/base_scaffold_normal.dart';
import 'package:house_merchant/screen/base/base_widget.dart';
import 'package:house_merchant/screen/base/image_widget.dart';
import 'package:house_merchant/utils/localizations_util.dart';
import 'package:intl/intl.dart';

class CouponDetailScreen extends StatefulWidget {
  dynamic params;

  CouponDetailScreen({this.params, Key key}) : super(key: key);

  @override
  CouponDetailScreenState createState() => new CouponDetailScreenState();
}

class CouponDetailScreenState extends State<CouponDetailScreen> {
  Size _screenSize;
  BuildContext _context;
  double _padding;
  CouponModel _couponModel;
  StreamController<ButtonSubmitEvent> qrButtonController =
      new StreamController<ButtonSubmitEvent>.broadcast();
  StreamController<ButtonSubmitEvent> editButtonController =
      new StreamController<ButtonSubmitEvent>.broadcast();
  String _scanBarCode = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this._couponModel = widget.params['coupon_model'] as CouponModel;
    this._screenSize = MediaQuery.of(context).size;
    this._context = context;
    this._padding = this._screenSize.width * 5 / 100;

    var _heightPhoto = this._screenSize.height * (300 / 818);

    int _status = _couponModel.status;

    if (_status == Promotion.approveStatus) {
      qrButtonController.sink.add(ButtonSubmitEvent(true));
    }

    final _statusWidget = Container(
      padding: EdgeInsets.all(this._padding),
      height: 70.0,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(30.0),
              topRight: const Radius.circular(30.0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Text(_couponModel.getUsedCound(),
                    style: TextStyle(
                        fontSize: ThemeConstant.boxes_font_title,
                        color: ThemeConstant.white_color,
                        fontWeight: ThemeConstant.fontWeightBold,
                        letterSpacing: 0.38)),
                SizedBox(width: 5.0),
                Text(
                  'Lượt sử dụng',
                  style: TextStyle(
                      fontSize: ThemeConstant.font_size_16,
                      letterSpacing: ThemeConstant.letter_spacing_026,
                      color: ThemeConstant.alto_color),
                ),
              ],
            ),
          ),
          RectangleLabelWidget(
            text: _couponModel.getStatusName(),
            color: _couponModel.getStatusColor(),
          )
        ],
      ),
    );

    Widget _timeRowFormat(String title, String content) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Expanded(
          Text(
            title,
            style: TextStyle(
                fontSize: 15,
                color: ThemeConstant.grey_color,
                letterSpacing: 0.24),
          ),
          Expanded(
              child: Text(
            content,
            textAlign: TextAlign.end,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.24,
                color: Colors.black),
          ))
        ],
      );
    }

    final _pendingStatusButton = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 160 * (_screenSize.width / 375),
          child: ButtonWidget(
              controller: qrButtonController,
              isActive: _status == Promotion.approveStatus,
              defaultHintText:
                  LocalizationsUtil.of(context).translate('Quét QR'),
              callback: () async {
                print('QR code clicked');
              }),
        ),
        Container(
          width: 160 * (_screenSize.width / 375),
          child: ButtonOutlineWidget(
              controller: editButtonController,
              isActive: _status == Promotion.pendingStatus,
              defaultHintText:
                  LocalizationsUtil.of(context).translate('Chỉnh sửa'),
              callback: () async {
                print('Edit clicked');
              }),
        )
      ],
    );

    Widget showErrorPopup() {
      final width = this._screenSize.width * 90 / 100;
      return Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
              width: width,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  SvgPicture.asset(
                    "assets/images/dialogs/ic-scan-failed.svg",
                  ),
                  SizedBox(height: 20),
                  Text(
                      LocalizationsUtil.of(context).translate('Quét thất bại!'),
                      style: TextStyle(
                        fontFamily: ThemeConstant.form_font_family_display,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.38,
                        color: ThemeConstant.black_color,
                      )),
                  SizedBox(height: 20),
                  Center(
                      child: Text(
                    LocalizationsUtil.of(context).translate(
                        'Mã QR không hợp lệ\nhoặc không tồn tại trong ưu đãi này.\nVui lòng kiểm tra lại thông tin'),
                    style: TextStyle(
                        fontFamily: ThemeConstant.form_font_family_display,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.26,
                        color: ThemeConstant.grey_color),
                    textAlign: TextAlign.center,
                  )),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 48.0,
                          child: BaseWidget.buttonThemePink('Thử lại',
                              callback: () {}),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                          child: Container(
                        height: 48.0,
                        child: BaseWidget.buttonOutline('Thoát', callback: () {
                          Navigator.of(context).pop();
                        }),
                      )),
                    ],
                  )
                ],
              )));
    }

    Future scanQR() async {
      String resultQRCode;
      var couponRepository = CouponRepository();

      try {
        resultQRCode = await FlutterBarcodeScanner.scanBarcode(
            "#7a1dff", "Hủy", true, ScanMode.QR);
      } on PlatformException {
        resultQRCode = 'Failed to get platform version.';
        T7GDialog.showAlertDialog(context, '', resultQRCode);
      }

      if (!mounted) return null;
      setState(() {
        _scanBarCode = resultQRCode;
      });
      String _id = _scanBarCode.split(',').first;
      String _code = _scanBarCode.split(',').last;

      if (_scanBarCode.length > 0 && _id != null && _code != null) {
        var rs = await couponRepository.scanQRCode(_id, _code);
        if (rs != null) {
          if (rs.isUsed == true) {
            T7GDialog.showAlertDialog(context, '', 'Mã này đã sử dụng!');
          } else {
            Router.push(_context, Router.COUPON_SCAN_QR_SUCCESS_PAGE, {
              "qr_code_model": rs,
              "callback": (QrCodeModel qrCodeModel) {
                //call api get user list
                print('===============> $qrCodeModel');
              }
            });
          }
        } else {
          T7GDialog.showContentDialog(context, [showErrorPopup()],
              closeShow: false, barrierDismissible: false);
        }
      }
    }

    Widget _scannerQRButton() {
      return ButtonWidget(
          controller: qrButtonController,
          isActive: _status == Promotion.approveStatus,
          defaultHintText: LocalizationsUtil.of(context).translate('Quét QR'),
          callback: () async {
            scanQR();
          });
    }

    Widget displayViewUserList() {
      return (this._couponModel.usedCount > 0)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(),
                InkWell(
                  onTap: () {
                    Router.push(_context, Router.COUPON_USER_LIST_PAGE,
                        {"coupon_model": _couponModel});
                  },
                  child: Container(
                      width: 130,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Xem danh sách',
                              style: TextStyle(
                                  color: ThemeConstant.primary_color,
                                  fontSize: 13,
                                  letterSpacing:
                                      ThemeConstant.letter_spacing_026,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(width: 10.0),
                          Icon(
                            Icons.arrow_forward,
                            color: ThemeConstant.violet_color,
                            size: 16.0,
                          )
                        ],
                      )),
                )
              ],
            )
          : Center();
    }

    return BaseScaffoldNormal(
      title: 'Chi tiết ưu đãi',
      child: SafeArea(
        child: Container(
          color: ThemeConstant.white_color,
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Stack(
            children: <Widget>[
//TODO: HEADER
              _couponModel.images.length > 0
                  ? ImageWidget(
                      width: _screenSize.width,
                      height: _heightPhoto,
                      imgUrl: _couponModel.images.first.image)
                  : SvgPicture.asset('assets/image/ic-promotion-default.svg',
                      fit: BoxFit.contain),

//TODO: BODY
              DraggableScrollableSheet(
                builder: (context, scrollController) {
                  return Container(
                    padding: EdgeInsets.only(bottom: 50),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0))),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _statusWidget,
                          Container(
                            height: 10.0,
                            decoration: BoxDecoration(
                                color: ThemeConstant.background_grey_color),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: displayViewUserList()),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      _couponModel.title,
                                      style: TextStyle(
                                          fontSize: ThemeConstant.font_size_24,
                                          letterSpacing:
                                              ThemeConstant.letter_spacing_038,
                                          color: ThemeConstant.black_color,
                                          fontWeight:
                                              ThemeConstant.fontWeightBold),
                                    ),
                                    SizedBox(height: 20.0),
                                    _timeRowFormat(
                                        'Thời gian bắt đầu:',
                                        DateFormat('HH:mm-dd/MM/yyyy').format(
                                            DateTime.parse(
                                                _couponModel.startDate))),
                                    SizedBox(height: 12.0),
                                    _timeRowFormat(
                                        'Thời gian kết thúc:',
                                        DateFormat('HH:mm-dd/MM/yyyy').format(
                                            DateTime.parse(
                                                _couponModel.endDate))),
                                    SizedBox(height: 20.0),
                                    Container(
                                      height: 2.0,
                                      decoration: BoxDecoration(
                                          color: ThemeConstant
                                              .background_grey_color),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Nội dung ưu đãi',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight:
                                              ThemeConstant.fontWeightBold,
                                          color: ThemeConstant.black_color,
                                          letterSpacing: 0.29),
                                    ),
                                    SizedBox(height: 10.0),
                                    ReadMoreText(
                                      _couponModel.description,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: ThemeConstant.grey_color,
                                          letterSpacing: 0.24),
                                      trimLines: 2,
                                      colorClickableText:
                                          ThemeConstant.primary_color,
                                      trimMode: TrimMode.Line,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      controller: scrollController,
                    ),
                  );
                },
                initialChildSize: 0.65,
                minChildSize: 0.65,
                maxChildSize: 1,
              ),
//TODO: BUTTON
              Positioned(
                bottom: 0,
                left: 0,
                width: _screenSize.width,
                child: Container(
                    padding: EdgeInsets.all(_padding),
                    width: _screenSize.width,
                    height: _status < Promotion.expireStatus ? 88.0 : 0,
                    decoration: BoxDecoration(color: Colors.white),
                    child: _status == Promotion.pendingStatus
                        ? _pendingStatusButton
                        : (_status == Promotion.approveStatus
                            ? _scannerQRButton()
                            : Center())),
              )
            ],
          ),
        ),
      ),
    );
  }
}
