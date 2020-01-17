import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/button_widget.dart';
import 'package:house_merchant/custom/read_more_text_widget.dart';
import 'package:house_merchant/custom/rectangle_label_widget.dart';
import 'package:house_merchant/middle/model/coupon_model.dart';
import 'package:house_merchant/router.dart';
import 'package:house_merchant/screen/base/base_scaffold_normal.dart';
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
  double _heightPhoto;
  String _statusName;
  CouponModel _couponModel;
  StreamController<ButtonSubmitEvent> qrButtonController =
      new StreamController<ButtonSubmitEvent>.broadcast();
  StreamController<ButtonSubmitEvent> editButtonController =
      new StreamController<ButtonSubmitEvent>.broadcast();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this._couponModel = widget.params['coupon_model'];

    this._screenSize = MediaQuery.of(context).size;
    this._context = context;
    this._padding = this._screenSize.width * 5 / 100;
    this._heightPhoto = this._screenSize.height * (300 / 812);
    this._statusName = _couponModel.getStatusName();

    final headerPhotoSection = Container(
        height: _heightPhoto,
        child: _couponModel.images.length > 0
            ? ImageWidget(
                width: _screenSize.width,
                height: _heightPhoto,
                imgUrl: _couponModel.images.first.image)
            : SvgPicture.asset('assets/image/ic-comming-soon.svg',
                fit: BoxFit.contain));

    Widget bottomButtonSection() {
      qrButtonController.sink.add(ButtonSubmitEvent(true));
      editButtonController.sink.add(ButtonSubmitEvent(true));

      final pendingStatusButton = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 160 * (_screenSize.width / 375),
            child: Center(
              child: Text(
                'Quét QR',
                style: TextStyle(
                    color: ThemeConstant.white_color,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            decoration: BoxDecoration(
              color: ThemeConstant.alto_color,
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
          ),
          Container(
            width: 160 * (_screenSize.width / 375),
            child: Center(
              child: Text(
                'Chỉnh sửa',
                style: TextStyle(
                    color: ThemeConstant.primary_color,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            decoration:
                ThemeConstant.borderOutline(ThemeConstant.primary_color),
          )
        ],
      );

      return Container(
        padding: EdgeInsets.all(_padding),
        width: _screenSize.width,
        height: 88.0,
        decoration: BoxDecoration(color: Colors.white),
        child: this._statusName == ThemeConstant.pending_status
            ? pendingStatusButton
            : ButtonWidget(
                controller: qrButtonController,
                defaultHintText:
                    LocalizationsUtil.of(context).translate('Quét QR'),
                callback: () async {}),
      );
    }

    // TODO: implement build
    return BaseScaffoldNormal(
        title: 'Chi tiết ưu đãi',
        child: SafeArea(
            child: Stack(children: <Widget>[
          Positioned(
            top: -5,
            left: 0,
            width: _screenSize.width,
            child: headerPhotoSection,
          ),
          Positioned(
            bottom: 88.0,
            left: 0.0,
            top: _heightPhoto - 70,
            width: _screenSize.width,
            child: promotionBody(_couponModel),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            width: _screenSize.width,
            child: bottomButtonSection(),
          ),
        ])));
  }

  Widget statusWidget(String status) {
    return Container(
      padding: EdgeInsets.all(20.0),
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
                Text('0/${_couponModel.quantity}',
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
  }

  Widget buildUserListWidget() {
    // final _userListSection = _couponModel.status == 0
    //     ? Center()
    //     : Container(
    final _userListSection = Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(),
          InkWell(
            onTap: () {
              Router.pushNoParams(_context, Router.COUPON_USER_LIST_PAGE);
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
                            letterSpacing: ThemeConstant.letter_spacing_026,
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
      ),
    );

//TODO: time section
    Widget timeRow(String title, String content) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontSize: 15,
                color: ThemeConstant.grey_color,
                letterSpacing: 0.24),
          ),
          Text(
            content,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.24,
                color: Colors.black),
          )
        ],
      );
    }

    final _timeSection = Padding(
      padding: EdgeInsets.only(bottom: 20.0, top: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _couponModel.title,
            style: TextStyle(
                fontSize: ThemeConstant.font_size_24,
                letterSpacing: ThemeConstant.letter_spacing_038,
                color: ThemeConstant.black_color,
                fontWeight: ThemeConstant.fontWeightBold),
          ),
          SizedBox(height: 20.0),
          timeRow(
              'Thời gian bắt đầu:',
              DateFormat('HH:mm - dd/MM/yyyy')
                  .format(DateTime.parse(_couponModel.startDate))),
          SizedBox(height: 12.0),
          timeRow(
              'Thời gian kết thúc:',
              DateFormat('HH:mm - dd/MM/yyyy')
                  .format(DateTime.parse(_couponModel.endDate))),
          SizedBox(height: 20.0),
          Container(
            height: 2.0,
            decoration:
                BoxDecoration(color: ThemeConstant.background_grey_color),
          )
        ],
      ),
    );

    return Expanded(
      child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            children: <Widget>[
              _userListSection,
              _timeSection,
              Text(
                'Nội dung ưu đãi',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: ThemeConstant.fontWeightBold,
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
                colorClickableText: ThemeConstant.primary_color,
                trimMode: TrimMode.Line,
              ),
            ],
          )),
    );
  }

  Widget promotionBody(CouponModel data) {
    // TODO: implement build
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          statusWidget(_couponModel.getStatusName()),
          SizedBox(height: 10.0),
          buildUserListWidget(),
        ]);
  }
}
