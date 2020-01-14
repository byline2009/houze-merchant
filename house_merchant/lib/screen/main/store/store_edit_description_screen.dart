import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/button_widget.dart';
import 'package:house_merchant/custom/textfield_widget.dart';
import 'package:house_merchant/screen/base/base_scaffold_normal.dart';
import 'package:house_merchant/utils/localizations_util.dart';
import 'package:house_merchant/utils/string_util.dart';

class StoreEditDescriptionScreen extends StatefulWidget {
  StoreEditDescriptionScreen({Key key}) : super(key: key);

  @override
  StoreEditDescriptionScreenState createState() =>
      new StoreEditDescriptionScreenState();
}

class StoreEditDescriptionScreenState
    extends State<StoreEditDescriptionScreen> {
  Size _screenSize;
  BuildContext _context;
  double _padding;
  StreamController<ButtonSubmitEvent> saveButtonController =
      new StreamController<ButtonSubmitEvent>.broadcast();
  final fdesc = TextFieldWidgetController();

  bool checkValidation() {
    var isActive = false;
    if (!StringUtil.isEmpty(fdesc.Controller.text)) {
      isActive = true;
    }
    saveButtonController.sink.add(ButtonSubmitEvent(isActive));
    return isActive;
  }

  Widget titleInSection(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: ThemeConstant.titleLargeStyle(Colors.black),
        ),
        SizedBox(height: 5),
        Text(
          subtitle,
          style: ThemeConstant.subtitleStyle(ThemeConstant.grey_color),
        )
      ],
    );
  }

  Widget buildBody() {
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
              titleInSection('Mô tả',
                  'Lời văn thật hay để cửa hàng bạn thu hút cư dân nhé!'),
              SizedBox(height: 30),
              Text(
                'Nội dung mô tả',
                style: ThemeConstant.subtitleStyle(ThemeConstant.primary_color),
              ),
              SizedBox(height: 5),
              TextFieldWidget(
                controller: fdesc,
                defaultHintText:
                    'Nhập mô tả, các điều khoản sử dụng ưu đãi của cửa hàng...',
                keyboardType: TextInputType.multiline,
                callback: (String value) {
                  this.checkValidation();
                },
              ),
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

    final buttonBottom = Positioned(
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
          buttonBottom
        ])));
  }
}
