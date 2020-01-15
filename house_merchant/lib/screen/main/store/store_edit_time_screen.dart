import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/button_widget.dart';
import 'package:house_merchant/custom/tags_widget.dart';
import 'package:house_merchant/screen/base/base_scaffold_normal.dart';
import 'package:house_merchant/utils/localizations_util.dart';

class StoreEditTimeScreen extends StatefulWidget {
  dynamic params;
  StoreEditTimeScreen({Key key, this.params}) : super(key: key);

  @override
  StoreEditTimeScreenState createState() => new StoreEditTimeScreenState();
}

class StoreEditTimeScreenState extends State<StoreEditTimeScreen> {
  Size _screenSize;
  BuildContext _context;
  double _padding;
  StreamController<ButtonSubmitEvent> saveButtonController =
      new StreamController<ButtonSubmitEvent>.broadcast();

  Widget buildBody() {
    Widget _titleSection(String title) {
      return Row(
        children: <Widget>[
          Text('*',
              style: TextStyle(
                fontFamily: ThemeConstant.form_font_family_display,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: ThemeConstant.required_color,
              )),
          SizedBox(width: 5),
          Text(LocalizationsUtil.of(context).translate(title),
              style: TextStyle(
                fontFamily: ThemeConstant.form_font_family_display,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.26,
                color: ThemeConstant.grey_color,
              ))
        ],
      );
    }

    Widget daySection() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TagsWidget(text: 'T2'),
          SizedBox(width: 10),
          TagsWidget(text: 'T3'),
          SizedBox(width: 10),
          TagsWidget(text: 'T4'),
          SizedBox(width: 10),
          TagsWidget(text: 'T5'),
          SizedBox(width: 10),
          TagsWidget(text: 'T6'),
          SizedBox(width: 10),
          TagsWidget(
            text: 'T7',
            isDisable: true,
          ),
          SizedBox(width: 10),
          TagsWidget(text: 'CN', isDisable: true),
        ],
      );
    }

    Column timeSection(String title) {
      return Column(
        children: <Widget>[
          _titleSection(title),
        ],
      );
    }

    return Positioned(
        right: 0.0,
        left: 0,
        bottom: 0,
        top: 10.0,
        child: Container(
          decoration: BoxDecoration(color: ThemeConstant.white_color),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Thời gian',
                style: ThemeConstant.titleLargeStyle(Colors.black),
              ),
              SizedBox(height: 30),
              _titleSection('Chọn ngày làm việc'),
              SizedBox(height: 10),
              daySection(),
              SizedBox(height: 30),
            ],
          ),
          padding: EdgeInsets.all(_padding),
        ));
  }

  @override
  Widget build(BuildContext context) {
    this._screenSize = MediaQuery.of(context).size;
    this._context = context;
    this._padding = this._screenSize.width * 5 / 100;

    final saveChangeButton = Positioned(
      bottom: 20.0,
      left: 20.0,
      right: 20.0,
      child: ButtonWidget(
          controller: saveButtonController,
          defaultHintText:
              LocalizationsUtil.of(_context).translate('Lưu thay đổi'),
          callback: () async {}),
    );

    // TODO: implement build
    return BaseScaffoldNormal(
        title: 'Chỉnh sửa cửa hàng',
        child: SafeArea(
            child: Stack(children: <Widget>[
          Container(
            decoration:
                BoxDecoration(color: ThemeConstant.background_grey_color),
          ),
          buildBody(),
          saveChangeButton
        ])));
  }
}
