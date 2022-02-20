import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/button_widget.dart';
import 'package:house_merchant/custom/datepick_range_widget.dart';
import 'package:house_merchant/custom/dialogs/T7GDialog.dart';
import 'package:house_merchant/custom/textfield_widget.dart';
import 'package:house_merchant/middle/model/coupon_model.dart';
import 'package:house_merchant/middle/model/image_meta_model.dart';
import 'package:house_merchant/middle/repository/coupon_repository.dart';
import 'package:house_merchant/screen/base/base_scaffold_normal.dart';
import 'package:house_merchant/screen/base/base_widget.dart';
import 'package:house_merchant/screen/base/boxes_container.dart';
import 'package:house_merchant/screen/base/picker_image.dart';
import 'package:house_merchant/utils/localizations_util.dart';
import 'package:house_merchant/utils/progresshub.dart';
import 'package:house_merchant/utils/string_util.dart';
import 'package:path/path.dart' as path;

typedef void CallBackHandler(dynamic value);

class CouponCreateScreen extends StatefulWidget {
  final dynamic params;

  CouponCreateScreen({@required this.params, Key? key}) : super(key: key);

  @override
  CouponCreateScreenState createState() => new CouponCreateScreenState();
}

class CouponCreateScreenState extends State<CouponCreateScreen> {
  ProgressHUD progressToolkit = Progress.instanceCreate();
  Size? _screenSize;
  double? _padding;

  //Reposioty
  final couponRepository = CouponRepository();

  //Form controller
  final ftitle = TextFieldWidgetController();
  final famount = TextFieldWidgetController();
  final frangeTime = new StreamController<List<DateTime>>.broadcast();
  List<DateTime>? frangeTimeResult;
  final fdesc = TextFieldWidgetController();
  StreamController<ButtonSubmitEvent> sendButtonController =
      new StreamController<ButtonSubmitEvent>.broadcast();
  final imagePicker = new PickerImage(
    width: 120,
    height: 120,
    type: PickerImageType.list,
    maxImage: 1,
  );
  //Model
  var couponModel = CouponModel(images: []);
  Map<String, ImageModel> mappingImages = new Map<String, ImageModel>();

  @override
  Widget build(BuildContext context) {
    this._screenSize = MediaQuery.of(context).size;
    this._padding = this._screenSize!.width * 5 / 100;

    return BaseScaffoldNormal(
      title: 'Tạo ưu đãi',
      child: Stack(children: <Widget>[
        CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
          SliverToBoxAdapter(
            child: BoxesContainer(
              child: Center(),
            ),
          ),
          SliverToBoxAdapter(
              child: BoxesContainer(
            title: 'Hình ảnh',
            child: this.imagePick(),
            padding: EdgeInsets.all(this._padding!),
          )),
          SliverToBoxAdapter(
              child: BoxesContainer(
            title: 'Thông tin',
            child: this.formCreate(),
            padding: EdgeInsets.all(this._padding!),
          )),
        ]),
        progressToolkit
      ]),
    );
  }

  bool checkValidation() {
    var isActive = false;
    if (imagePicker.state.filesPick.length > 0 &&
        !StringUtil.isEmpty(ftitle.controller.text) &&
        !StringUtil.isEmpty(famount.controller.text) &&
        frangeTimeResult != null &&
        !StringUtil.isEmpty(fdesc.controller.text)) {
      isActive = true;
    }
    sendButtonController.sink.add(ButtonSubmitEvent(isActive));
    return isActive;
  }

  void clearForm() {
    ftitle.controller.clear();
    famount.controller.clear();
    frangeTimeResult = null;
    frangeTime.add([]);
    fdesc.controller.clear();
    imagePicker.clear();
    sendButtonController.add(ButtonSubmitEvent(false));
  }

  Widget controlHeader(String title) {
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
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.26,
              color: ThemeConstant.grey_color,
            ))
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget formCreate() {
    return Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
                LocalizationsUtil.of(context).translate(
                    'Vui lòng điền đầy đủ các thông tin ưu đãi dưới đây'),
                style: TextStyle(
                  fontFamily: ThemeConstant.form_font_family_display,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.23,
                  color: ThemeConstant.grey_color,
                )),
            SizedBox(height: 25),
            this.controlHeader(
              'Tiêu đề ưu đãi',
            ),
            SizedBox(height: 5),
            TextFieldWidget(
                controller: ftitle,
                defaultHintText: 'Vd: Mua 1 tặng 1 tất cả chi nhánh',
                callback: (String value) {
                  this.checkValidation();
                }),
            SizedBox(height: 25),
            this.controlHeader(
              'Số lượng',
            ),
            SizedBox(height: 5),
            TextFieldWidget(
                controller: famount,
                defaultHintText: 'Vd: 50',
                keyboardType: TextInputType.number,
                callback: (String value) {
                  this.checkValidation();
                }),
            SizedBox(height: 25),
            this.controlHeader(
              'Thời gian hiệu lực',
            ),
            SizedBox(height: 5),
            DateRangePickerWidget(
              controller: frangeTime,
              defaultHintText: '00:00 - DD/MM/YYYY đến 00:00 - DD/MM/YYYY',
              callback: (List<DateTime> values) {
                if (values.length == 2) {
                  frangeTimeResult = values;
                  this.checkValidation();
                }
              },
            ),
            SizedBox(height: 25),
            this.controlHeader(
              'Nội dung ưu đãi',
            ),
            SizedBox(height: 5),
            TextFieldWidget(
                controller: fdesc,
                defaultHintText:
                    'Nhập mô tả, các điều khoản sử dụng ưu đãi của cửa hàng...',
                keyboardType: TextInputType.multiline,
                callback: (String value) {
                  this.checkValidation();
                }),
            SizedBox(height: 25),
            ButtonWidget(
                controller: sendButtonController,
                defaultHintText:
                    LocalizationsUtil.of(context).translate('Tạo ưu đãi'),
                callback: () async {
                  try {
                    progressToolkit.state.show();
                    final _couponModel = CouponModel(
                      title: ftitle.controller.text,
                      quantity: int.parse(famount.controller.text),
                      startDate: frangeTimeResult![0].toUtc().toString(),
                      endDate: frangeTimeResult![1].toUtc().toString(),
                      description: fdesc.controller.text,
                      images: couponModel.images,
                    );

                    await couponRepository.createCoupon(_couponModel);
                    T7GDialog.showContentDialog(
                        context, [this._navigatedToPromotionListScreen()],
                        closeShow: false, barrierDismissible: false);

                    //Clear all
                    this.clearForm();
                  } catch (e) {
                    Fluttertoast.showToast(
                        msg: e.toString(),
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 5,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 14.0);
                  } finally {
                    progressToolkit.state.dismiss();
                  }
                })
          ],
        ));
  }

  Widget imagePick() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 5),
        Text(
            LocalizationsUtil.of(context).translate(
                'Vui lòng điền đầy đủ các thông tin ưu đãi dưới đây'),
            style: TextStyle(
              fontFamily: ThemeConstant.form_font_family_display,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.23,
              color: ThemeConstant.grey_color,
            )),
        SizedBox(height: 15),
        imagePicker,
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    imagePicker.callbackUpload = (FilePick f) async {
      final rs = await couponRepository.uploadImage(f.file!);
      if (rs != null) {
        var uploadModel = new ImageModel(id: rs.id);
        couponModel.images!.add(uploadModel);
        mappingImages[path.basename(f.file!.path)] = uploadModel;
      }
      this.checkValidation();
    };

    imagePicker.callbackRemove = (FilePick f) async {
      couponModel.images!.remove(mappingImages[path.basename(f.file!.path)]);
      this.checkValidation();
    };
  }

  Widget _navigatedToPromotionListScreen() {
    final width = this._screenSize!.width * 90 / 100;
    return Padding(
        padding: EdgeInsets.all(20),
        child: Container(
            width: width,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                SvgPicture.asset(
                  "assets/images/dialogs/graphic-voucher.svg",
                ),
                SizedBox(height: 20),
                Text(
                    LocalizationsUtil.of(context)
                        .translate('Tạo ưu đãi thành công!'),
                    style: TextStyle(
                      fontFamily: ThemeConstant.form_font_family_display,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.26,
                      color: ThemeConstant.black_color,
                    )),
                SizedBox(height: 20),
                Center(
                    child: Text(
                  LocalizationsUtil.of(context).translate(
                      'Ưu đãi của bạn sẽ được duyệt bởi\nHouse Merchant trước khi đăng lên\nứng dụng cư dân'),
                  style: TextStyle(
                      fontFamily: ThemeConstant.form_font_family_display,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.26,
                      color: ThemeConstant.grey_color,
                      height: 1.5),
                  textAlign: TextAlign.center,
                )),
                SizedBox(height: 20),
                BaseWidget.buttonThemePink('Về trang chính', callback: () {
                  Navigator.of(context).popUntil((route) {
                    if (widget.params['callback'] != null) {
                      widget.params['callback'](true);
                    }
                    return route.isFirst;
                  });
                })
              ],
            )));
  }
}
