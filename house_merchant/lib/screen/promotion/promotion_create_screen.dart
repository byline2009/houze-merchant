import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/button_widget.dart';
import 'package:house_merchant/custom/datepick_range_widget.dart';
import 'package:house_merchant/custom/textfield_widget.dart';
import 'package:house_merchant/middle/model/coupon_model.dart';
import 'package:house_merchant/middle/repository/coupon_repository.dart';
import 'package:house_merchant/screen/base/base_scaffold_normal.dart';
import 'package:house_merchant/screen/base/boxes_container.dart';
import 'package:house_merchant/utils/localizations_util.dart';
import 'package:house_merchant/utils/string_util.dart';

class PromotionCreateScreen extends StatefulWidget {

  PromotionCreateScreen({Key key}) : super(key: key);

  @override
  PromotionCreateScreenState createState() => new PromotionCreateScreenState();
}

class PromotionCreateScreenState extends State<PromotionCreateScreen> {

  Size _screenSize;
  BuildContext _context;
  double _padding;

  //Reposioty
  final couponRepository = CouponRepository();

  //Form controller
  final ftitle = TextFieldWidgetController();
  final famount = TextFieldWidgetController();
  final frangeTime = new StreamController<List<DateTime>>.broadcast();
  List<DateTime> frangeTimeResult;
  final fdesc = TextFieldWidgetController();
  StreamController<ButtonSubmitEvent> sendButtonController = new StreamController<ButtonSubmitEvent>.broadcast();

  @override
  void initState() {
    super.initState();
  }

  bool checkValidation() {
    var isActive = false;
    if (!StringUtil.isEmpty(ftitle.Controller.text) && !StringUtil.isEmpty(famount.Controller.text) 
      && frangeTimeResult!=null && !StringUtil.isEmpty(fdesc.Controller.text)) {
      isActive = true;
    }
    sendButtonController.sink.add(ButtonSubmitEvent(isActive));
    return isActive;
  }

  Widget controlHeader(String title) {

    return Row(
      children: <Widget>[

        Text('*', style: TextStyle(
          fontFamily: ThemeConstant.form_font_family_display,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: ThemeConstant.required_color,
        )),
        SizedBox(width: 5),
        Text(LocalizationsUtil.of(context).translate(title),
          style: TextStyle(
            fontFamily: ThemeConstant.form_font_family_display,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.26,
            color: ThemeConstant.grey_color,
          )
        )

      ],
    );

  }

  Widget formCreate() {

    final padding = this._screenSize.width * 5 / 100;
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          Text(LocalizationsUtil.of(context).translate('Vui lòng điền đầy đủ các thông tin ưu đãi dưới đây'), 
            style: TextStyle(
              fontFamily: ThemeConstant.form_font_family_display,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.23,
              color: ThemeConstant.grey_color,
            )
          ),
          SizedBox(height: 25),

          this.controlHeader('Tiêu đề ưu đãi',),
          SizedBox(height: 5),
          TextFieldWidget(controller: ftitle, defaultHintText: 'Vd: Mua 1 tặng 1 tất cả chi nhánh', callback: (String value) {
            this.checkValidation();
          }),

          SizedBox(height: 25),

          this.controlHeader('Số lượng',),
          SizedBox(height: 5),
          TextFieldWidget(controller: famount, defaultHintText: 'Vd: 50', keyboardType: TextInputType.number, callback: (String value) {
            this.checkValidation();
          }),

          SizedBox(height: 25),

          this.controlHeader('Thời gian hiệu lực',),
          SizedBox(height: 5),
          DateRangePickerWidget(controller: frangeTime, defaultHintText: '00:00 - DD/MM/YYYY đến 00:00 - DD/MM/YYYY', callback: (List<DateTime> values) {
            if (values.length == 2) {
              frangeTimeResult = values;
              this.checkValidation();
            }
          },),

          SizedBox(height: 25),
          this.controlHeader('Nội dung ưu đãi',),
          SizedBox(height: 5),
          TextFieldWidget(controller: fdesc, defaultHintText: 'Nhập mô tả, các điều khoản sử dụng ưu đãi của cửa hàng...', keyboardType: TextInputType.multiline, callback: (String value) {
            this.checkValidation();
          }),
          
          SizedBox(height: 25),
          ButtonWidget(controller: sendButtonController, defaultHintText: LocalizationsUtil.of(context).translate('Tạo ưu đãi'), callback: () async {
            final result = await couponRepository.createCoupon(CouponModel(
              title: ftitle.Controller.text,
              quantity: int.parse(famount.Controller.text),
              startDate: frangeTimeResult[0].toUtc().toString(),
              endDate: frangeTimeResult[1].toUtc().toString(),
              description: fdesc.Controller.text
            ));
            print(result);
          })
        ],
      )
    );
    
  }

  @override
  Widget build(BuildContext context) {
    
    this._screenSize = MediaQuery.of(context).size;
    this._context = context;
    this._padding = this._screenSize.width * 5 / 100;

    return BaseScaffoldNormal(
      title: 'Tạo ưu đãi',
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [

          SliverToBoxAdapter(
            child: BoxesContainer(child: Center(),),
          ),

          SliverToBoxAdapter(
            child: BoxesContainer(title: 'Hình ảnh', child: Text('hello world'), padding: EdgeInsets.all(this._padding),)
          ),

          SliverToBoxAdapter(
            child: BoxesContainer(title: 'Thông tin', child: this.formCreate(), padding: EdgeInsets.all(this._padding),)
          ),
        ]
      ),
    );

  }

  @override
  void dispose() {
    super.dispose();
  }
}