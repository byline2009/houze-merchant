import 'dart:async';
import 'package:house_merchant/custom/datepick_range_custom_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/button_widget.dart';
import 'package:house_merchant/custom/dialogs/T7GDialog.dart';
import 'package:house_merchant/custom/textfield_widget.dart';
import 'package:house_merchant/middle/bloc/coupon/indext.dart';
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

typedef void CallBackHandler(dynamic value);

class CouponEditScreen extends StatefulWidget {
  final dynamic params;

  CouponEditScreen({@required this.params, Key? key}) : super(key: key);

  @override
  CouponEditScreenState createState() => new CouponEditScreenState();
}

class CouponEditScreenState extends State<CouponEditScreen> {
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

  StreamController<ButtonSubmitEvent> saveButtonController =
      new StreamController<ButtonSubmitEvent>.broadcast();
  final imagePicker = new PickerImage(
    width: 120,
    height: 120,
    type: PickerImageType.list,
    maxImage: 1,
  );
  //Model

  List<ImageModel> _imgList = <ImageModel>[];
  Map<String, ImageModel> mappingImages = new Map<String, ImageModel>();

  bool imageValidation() {
    if (_imgList.length > 0) {
      var img = _imgList.first;
      var rs =
          img.id != null && img.image!.length > 0 && img.imageThumb!.length > 0;
      return rs;
    }
    return false;
  }

  bool checkValidation() {
    var isActive = false;
    if (imageValidation() &&
        !StringUtil.isEmpty(ftitle.controller.text) &&
        !StringUtil.isEmpty(famount.controller.text) &&
        frangeTimeResult != null &&
        !StringUtil.isEmpty(fdesc.controller.text)) {
      isActive = true;
    }
    saveButtonController.sink.add(ButtonSubmitEvent(isActive));
    return isActive;
  }

  @override
  void initState() {
    this.fetchData();
    this.callbackImagePickerDelegate();

    super.initState();
    this.checkValidation();
  }

  void fetchData() {
    var data = new CouponModel();

    data = widget.params['coupon_model'];
    _imgList = data.images!;
    ftitle.controller.text = data.title!;
    fdesc.controller.text = data.description!;
    famount.controller.text = data.quantity.toString();
    frangeTimeResult = [
      DateTime.parse(data.startDate!).toLocal(),
      DateTime.parse(data.endDate!).toLocal()
    ];

    final initImages = _imgList
        .map(
          (f) => FilePick(id: f.id, url: f.image, urlThumb: f.imageThumb),
        )
        .toList();
    if (_imgList.length > 0) {
      mappingImages[_imgList.last.imageThumb!] = _imgList.last;
    }
    imagePicker.imagesInit = initImages;
  }

  void callbackImagePickerDelegate() {
    imagePicker.callbackUpload = (FilePick f) async {
      final rs = await couponRepository.uploadImage(f.file!);

      if (rs != null) {
        ImageModel? img = mappingImages[rs.imageThumb];
        if (img == null) {
          mappingImages[rs.imageThumb!] = rs;
          _imgList.add(rs);
        }
      }

      this.checkValidation();
    };

    imagePicker.callbackRemove = (FilePick f) async {
      ImageModel? img = mappingImages[f.urlThumb];

      if (img!.imageThumb != null) {
        _imgList.remove(img);
      }

      this.checkValidation();
    };
  }

  void clearForm() {
    ftitle.controller.clear();
    famount.controller.clear();
    frangeTimeResult = null;
    frangeTime.add([]);
    fdesc.controller.clear();
    imagePicker.clear();
    saveButtonController.add(ButtonSubmitEvent(false));
  }

  Widget buildBody(CouponBloc bloc) {
    return Stack(children: <Widget>[
      CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
        SliverToBoxAdapter(
            child: BoxesContainer(
          child: Center(),
        )),
        SliverToBoxAdapter(
            child: BoxesContainer(
          title: 'Hình ảnh',
          child: this.imagePick(),
          padding: EdgeInsets.all(this._padding!),
        )),
        SliverToBoxAdapter(
            child: BoxesContainer(
          title: 'Thông tin',
          child: this.formCreate(bloc),
          padding: EdgeInsets.all(this._padding!),
        )),
      ]),
      progressToolkit
    ]);
  }

  @override
  Widget build(BuildContext context) {
    var couponBloc = CouponBloc(CouponInitial());

    this._screenSize = MediaQuery.of(context).size;
    this._padding = this._screenSize!.width * 5 / 100;

    return BaseScaffoldNormal(
        title: 'Chỉnh sửa ưu đãi',
        child: SafeArea(
            child: BlocListener(
                bloc: couponBloc,
                listener: (context, state) {
                  if (state is CouponFailure) {
                    Fluttertoast.showToast(
                        msg: state.error.toString(),
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 5,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 14.0);
                  }
                },
                child: BlocBuilder<CouponBloc, CouponState>(
                    bloc: couponBloc,
                    builder: (
                      BuildContext context,
                      CouponState state,
                    ) {
                      print(state);
                      if (state is CouponLoading) {
                        progressToolkit.state.show();
                      }

                      return buildBody(couponBloc);
                    }))));
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

  Widget formCreate(CouponBloc bloc) {
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
            Container(
                child: frangeTimeResult!.length == 2
                    ? DateRangePickerCustomWidget(
                        firstDate: frangeTimeResult![0].toLocal(),
                        lastDate: frangeTimeResult![1].toLocal(),
                        controller: frangeTime,
                        defaultHintText:
                            '00:00 - DD/MM/YYYY đến 00:00 - DD/MM/YYYY',
                        callback: (List<DateTime> values) {
                          if (values.length == 2) {
                            frangeTimeResult = values;
                            this.checkValidation();
                          }
                        },
                      )
                    : Center()),
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
            saveDataButton(bloc)
          ],
        ));
  }

  Widget saveDataButton(CouponBloc couponBloc) {
    return ButtonWidget(
        isActive: this.checkValidation(),
        controller: saveButtonController,
        defaultHintText:
            LocalizationsUtil.of(context).translate('Lưu chỉnh sửa'),
        callback: () async {
          CouponModel coupon = widget.params['coupon_model'];

          final data = CouponModel(
              title: ftitle.controller.text,
              quantity: int.parse(famount.controller.text),
              startDate: frangeTimeResult![0].toUtc().toString(),
              endDate: frangeTimeResult![1].toUtc().toString(),
              description: fdesc.controller.text,
              images: [_imgList.first],
              shops: coupon.shops);

          print(data.toJson().toString());

          final result = await couponRepository.updateCoupon(coupon.id!, data);

          if (result != null) {
            if (widget.params['callback'] != null) {
              widget.params['callback'](result);
            }

            T7GDialog.showContentDialog(
                context, [_navigatedToPromotionListScreen(result)],
                closeShow: false, barrierDismissible: true);

            progressToolkit.state.dismiss();
          } else {
            Fluttertoast.showToast(
                msg: 'Đã có lỗi xảy ra. Vui lòng thử lại sau!',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 4,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 14.0);

            progressToolkit.state.dismiss();
          }
        });
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

  Widget _navigatedToPromotionListScreen(CouponModel rs) {
    final width = this._screenSize!.width * 90 / 100;
    return Padding(
        padding: EdgeInsets.all(20),
        child: Container(
            width: width,
            child: Column(children: <Widget>[
              SizedBox(height: 20),
              SvgPicture.asset(
                "assets/images/dialogs/graphic-voucher.svg",
              ),
              SizedBox(height: 20),
              Text(
                LocalizationsUtil.of(context)
                    .translate('Chỉnh sửa ưu đãi thành công!'),
                style: TextStyle(
                    fontFamily: ThemeConstant.form_font_family_display,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.26,
                    color: ThemeConstant.black_color),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
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
                      textAlign: TextAlign.center)),
              SizedBox(height: 20),
              Container(
                height: 48.0,
                child:
                    BaseWidget.buttonThemePink('Về trang chính', callback: () {
                  Navigator.of(context).popUntil((route) {
                    return route.isFirst;
                  });
                }),
              ),
            ])));
  }
}
