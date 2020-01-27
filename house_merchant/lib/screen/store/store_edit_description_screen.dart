import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/button_widget.dart';
import 'package:house_merchant/custom/textfield_style1_widget.dart';
import 'package:house_merchant/custom/textfield_widget.dart';
import 'package:house_merchant/middle/bloc/shop/index.dart';
import 'package:house_merchant/middle/bloc/shop/shop_bloc.dart';
import 'package:house_merchant/middle/bloc/shop/shop_event.dart';
import 'package:house_merchant/middle/model/shop_model.dart';
import 'package:house_merchant/middle/repository/shop_repository.dart';
import 'package:house_merchant/screen/base/base_scaffold_normal.dart';
import 'package:house_merchant/utils/localizations_util.dart';
import 'package:house_merchant/utils/progresshub.dart';
import 'package:house_merchant/utils/string_util.dart';

class StoreEditDescriptionScreen extends StatefulWidget {
  dynamic params;
  StoreEditDescriptionScreen({Key key, this.params}) : super(key: key);

  @override
  StoreEditDescriptionScreenState createState() =>
      new StoreEditDescriptionScreenState();
}

class StoreEditDescriptionScreenState
    extends State<StoreEditDescriptionScreen> {
  Size _screenSize;
  double _padding;

  ShopRepository shopRepository = new ShopRepository();
  final fdesc = TextFieldWidgetController();

  StreamController<ButtonSubmitEvent> saveButtonController =
      new StreamController<ButtonSubmitEvent>.broadcast();
  ProgressHUD progressToolkit = Progress.instanceCreate();

  @override
  void initState() {
    ShopModel data = widget.params['shop_model'];
    fdesc.Controller.text = data.description;
    super.initState();
  }

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
            padding: EdgeInsets.all(_padding),
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
                    style: ThemeConstant.subtitleStyle(
                        ThemeConstant.grey_color),
                  ),
                  SizedBox(height: 5),
                  TextFieldWidget(
                    controller: fdesc,
                    defaultHintText:
                        'Nhập mô tả, các điều khoản sử dụng ưu đãi của cửa hàng...',
                    keyboardType: TextInputType.multiline,
                    callback: (String value) {
                      checkValidation();
                    })
                ])));
  }

  @override
  Widget build(BuildContext context) {
    final shopBloc = ShopBloc();
    this._screenSize = MediaQuery.of(context).size;
    this._padding = this._screenSize.width * 5 / 100;

    var shopModel = widget.params['shop_model'] as ShopModel;

    Widget saveDataButton(ShopBloc shopBloc) {
      return Positioned(
          bottom: 20.0,
          left: 20.0,
          right: 20.0,
          child: ButtonWidget(
              controller: saveButtonController,
              defaultHintText:
                  LocalizationsUtil.of(context).translate('Lưu thay đổi'),
              callback: () async {
                shopBloc
                    .add(SaveButtonPressed(name: shopModel.name, description: fdesc.Controller.text));
              }));
    }

    // TODO: implement build
    return BaseScaffoldNormal(
        title: 'Chỉnh sửa cửa hàng',
        child: SafeArea(
          child: BlocListener(
            bloc: shopBloc,
            listener: (context, state) async {
              if (state is ShopSuccessful) {
                progressToolkit.state.show();
                if ( widget.params['callback']!=null ) {
                  var shopModel = widget.params['shop_model'] as ShopModel;
                  shopModel.description = fdesc.Controller.text;
                  widget.params['callback'](shopModel);
                }
                Navigator.of(context).pop();
              }

              if (state is ShopFailure) {
                Fluttertoast.showToast(
                  msg: state.error.toString(),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIos: 5,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 14.0
                );
                progressToolkit.state.dismiss();
              }
            },
            child: BlocBuilder<ShopBloc, ShopState>(
              bloc: shopBloc,
              builder: (
                BuildContext context,
                ShopState state,
            ) {

              if (state is ShopLoading) {
                progressToolkit.state.show();
              }

              return Stack(children: <Widget>[
                Container(
                  decoration: BoxDecoration(color: ThemeConstant.background_grey_color),
                ),
                buildBody(),
                saveDataButton(shopBloc),
                progressToolkit
              ]);
            }))
    ));
  }
}
