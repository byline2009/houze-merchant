import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:house_merchant/constant/common_constant.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/button_outline_widget.dart';
import 'package:house_merchant/custom/read_more_text_widget.dart';
import 'package:house_merchant/custom/rectangle_label_widget.dart';
import 'package:house_merchant/middle/model/coupon_model.dart';
import 'package:house_merchant/router.dart';
import 'package:house_merchant/screen/base/base_scaffold_normal.dart';
import 'package:house_merchant/screen/base/image_widget.dart';
import 'package:intl/intl.dart';

class PromoDetailScreen extends StatefulWidget {
  final dynamic params;

  PromoDetailScreen({@required this.params, Key key}) : super(key: key);

  @override
  PromoDetailScreenState createState() => new PromoDetailScreenState();
}

class PromoDetailScreenState extends State<PromoDetailScreen> {
  Size _screenSize;
  var _padding;
  CouponModel _couponModel;

  @override
  void initState() {
    super.initState();
    _couponModel = widget.params['coupon_model'];
  }

  @override
  Widget build(BuildContext context) {
    this._screenSize = MediaQuery.of(context).size;
    this._padding = this._screenSize.width * 5 / 100;
    var _heightPhoto = this._screenSize.height * (300 / 818);

    var headerImage = _couponModel.images.length > 0
        ? ImageWidget(
            width: _screenSize.width,
            height: _heightPhoto,
            imgUrl: _couponModel.images.first.image)
        : SvgPicture.asset('assets/image/ic-promotion-default.svg',
            fit: BoxFit.contain);

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
            text: _couponModel.statusName(),
            color: _couponModel.satusColor(),
          )
        ],
      ),
    );

    Widget _timeRowFormat(String title, String content) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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

    Widget viewUserList() {
      return (this._couponModel.usedCount > 0)
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(),
                    InkWell(
                        onTap: () {
                          Router.push(context, Router.COUPON_USER_LIST_PAGE,
                              {"coupon_model": _couponModel});
                        },
                        child: Container(
                            width: 130,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Xem danh sách',
                                      style: TextStyle(
                                          color: ThemeConstant.primary_color,
                                          fontSize: 13,
                                          letterSpacing:
                                              ThemeConstant.letter_spacing_026,
                                          fontWeight: FontWeight.w600)),
                                  SizedBox(width: 10.0),
                                  Icon(Icons.arrow_forward,
                                      color: ThemeConstant.violet_color,
                                      size: 16.0)
                                ])))
                  ]))
          : Center();
    }

    Widget _bodyContent() {
      return Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
            viewUserList(),
            Text(
              _couponModel.title,
              style: TextStyle(
                  fontSize: ThemeConstant.font_size_24,
                  letterSpacing: ThemeConstant.letter_spacing_038,
                  color: ThemeConstant.black_color,
                  fontWeight: ThemeConstant.fontWeightBold),
            ),
            SizedBox(height: 20.0),
            _timeRowFormat(
                'Thời gian bắt đầu:',
                DateFormat(Format.timeAndDate)
                    .format(DateTime.parse(_couponModel.startDate).toLocal())),
            SizedBox(height: 12.0),
            _timeRowFormat(
                'Thời gian kết thúc:',
                DateFormat(Format.timeAndDate)
                    .format(DateTime.parse(_couponModel.endDate).toLocal())),
            SizedBox(height: 20.0),
            Container(
              height: 2.0,
              decoration:
                  BoxDecoration(color: ThemeConstant.background_grey_color),
            ),
            SizedBox(
              height: 20,
            ),
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
            )
          ]));
    }

    return BaseScaffoldNormal(
      title: 'Chi tiết ưu đãi',
      callback: () {
        Navigator.of(context).popUntil((route) {
          //scan qr code success => promotion list need to reload data
          if (widget.params['callback'] != null) {
            widget.params['callback'](true);
          }
          return route.isFirst;
        });
      },
      child: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  headerImage,
                  Positioned(child: _statusWidget, bottom: 0, left: 0, right: 0)
                ],
              ),
              SizedBox(
                  height: 10,
                  child: Container(color: ThemeConstant.background_grey_color)),
              Container(
                padding: EdgeInsets.all(this._padding),
                color: ThemeConstant.white_color,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _bodyContent(),
                    (_couponModel.status == Promotion.pendingStatus)
                        ? ButtonOutlineWidget(
                            defaultHintText: 'Chỉnh sửa',
                            isActive: true,
                            callback: () {
                              print('click chinh sua');
                            },
                          )
                        : Center()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomSection() {}
}
