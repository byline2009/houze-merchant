import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/button_widget.dart';
import 'package:house_merchant/custom/read_more_text_widget.dart';
import 'package:house_merchant/custom/rectangle_label_widget.dart';
import 'package:house_merchant/screen/base/base_scaffold_normal.dart';
import 'package:house_merchant/utils/localizations_util.dart';

class PromotionDetailScreen extends StatefulWidget {
  PromotionDetailScreen({Key key}) : super(key: key);

  @override
  PromotionDetailScreenState createState() => new PromotionDetailScreenState();
}

class PromotionDetailScreenState extends State<PromotionDetailScreen> {
  Size _screenSize;
  BuildContext _context;
  double _padding;
  double _heightPhoto;
  String _status;
  StreamController<ButtonSubmitEvent> qrButtonController =
      new StreamController<ButtonSubmitEvent>.broadcast();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this._screenSize = MediaQuery.of(context).size;
    this._context = context;
    this._padding = this._screenSize.width * 5 / 100;
    this._heightPhoto = this._screenSize.height * (300 / 812);
    this._status = ThemeConstant.pending_status;

    final headerPhotoSection = Container(
      height: _heightPhoto,
      child: SvgPicture.asset('assets/images/ic-comming-soon.svg',
          fit: BoxFit.none),
    );

    Widget bottomButtonSection(String status) {
      qrButtonController.sink.add(ButtonSubmitEvent(true));

      return Container(
        padding: EdgeInsets.all(_padding),
        width: _screenSize.width,
        height: 88.0,
        decoration: BoxDecoration(color: Colors.white),
        child: ButtonWidget(
            controller: qrButtonController,
            defaultHintText: LocalizationsUtil.of(context).translate('Quét QR'),
            callback: () async {}),
      );
    }

    // TODO: implement build
    return BaseScaffoldNormal(
        title: 'Chi tiết ưu đãi',
        child: SafeArea(
            child: Stack(children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            width: _screenSize.width,
            child: headerPhotoSection,
          ),
          Positioned(
            bottom: 88.0,
            left: 0.0,
            top: _heightPhoto - 70,
            width: _screenSize.width,
            child: PromotionBody(),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            width: _screenSize.width,
            child: bottomButtonSection(_status),
          ),
        ])));
  }
}

class PromotionBody extends StatefulWidget {
  @override
  PromotionBodyState createState() {
    // TODO: implement createState
    return PromotionBodyState();
  }
}

class PromotionBodyState extends State<PromotionBody> {
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
                Text('21/50',
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
            text: 'Đang chạy',
            color: ThemeConstant.ready_color,
          )
        ],
      ),
    );
  }

  Widget buildListView() {
    final _userListSection = Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.greenAccent[100],
                child: Text('A'),
              ),
              CircleAvatar(
                backgroundColor: Colors.pinkAccent[100],
                child: Text('C'),
              ),
            ],
          )),
          InkWell(
            onTap: () {
              print('Xem danh sach');
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
            'Ưu đãi 25% mừng Lễ Giáng Sinh 2019',
            style: TextStyle(
                fontSize: ThemeConstant.font_size_24,
                letterSpacing: ThemeConstant.letter_spacing_038,
                color: ThemeConstant.black_color,
                fontWeight: ThemeConstant.fontWeightBold),
          ),
          SizedBox(height: 20.0),
          timeRow('Thời gian bắt đầu:', '06:00 - 20/12/2019'),
          SizedBox(height: 12.0),
          timeRow('Thời gian kết thúc:', '23:59 - 26/12/2019'),
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
                'Thích thì dùng, không thích thì dùng.\n \n Please dontsubmit pull requests directly updating this file.\n \n While were always happy to learn of new samples from the community, we need to keep this file small.\n \nThere are plenty of user-maintained indices (like Awesome Flutter) that are meant to be exhaustive, and those are great places for submitting your own work.',
                trimLines: 2,
                colorClickableText: ThemeConstant.primary_color,
                trimMode: TrimMode.Line,
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          statusWidget('pending'),
          SizedBox(height: 10.0),
          buildListView(),
        ]);
  }
}
