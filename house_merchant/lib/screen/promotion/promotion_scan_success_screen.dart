import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/button_widget.dart';
import 'package:house_merchant/middle/model/qrcode_model.dart';
import 'package:house_merchant/middle/repository/coupon_repository.dart';
import 'package:house_merchant/router.dart';
import 'package:house_merchant/screen/base/base_widget.dart';
import 'package:house_merchant/screen/base/boxes_container.dart';
import 'package:house_merchant/utils/localizations_util.dart';
import 'package:house_merchant/utils/progresshub.dart';

class PromotionScanSuccessScreen extends StatefulWidget {
  final dynamic params;
  PromotionScanSuccessScreen({@required this.params, key}) : super(key: key);

  @override
  PromotionScanSuccessState createState() => new PromotionScanSuccessState();
}

class PromotionScanSuccessState extends State<PromotionScanSuccessScreen> {
  var _qrCodeModel = QrCodeModel();
  double _padding;
  Size _screenSize;

  @override
  Widget build(BuildContext context) {
    this._qrCodeModel = widget.params['qr_code_model'];
    this._screenSize = MediaQuery.of(context).size;
    this._padding = this._screenSize.width * 5 / 100;
    var _user = this._qrCodeModel.customer;
    var _coupon = this._qrCodeModel.coupon;
    ProgressHUD progressToolkit = Progress.instanceCreate();

    void confirmQR() async {
      try {
        progressToolkit.state.show();

        var couponRepository = CouponRepository();

        var rs = await couponRepository.confirmCode(
            this._qrCodeModel.id, this._qrCodeModel.code);
        if (rs != null) {
          AppRouter.push(context, AppRouter.COUPON_DETAIL_PAGE, {
            "coupon_model": rs.coupon,
            'callback': (reload) {
              if (reload && widget.params['callback'] != null) {
                widget.params['callback'](true);
              }
              return;
            }
          });
        }
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
    }

    final buttonBottom = ButtonWidget(
        isActive: true,
        defaultHintText:
            LocalizationsUtil.of(context).translate('Xác nhận sử dụng mã'),
        callback: () async {
          confirmQR();
        });

    return Scaffold(
        appBar: AppBar(
            title: Text(
                LocalizationsUtil.of(context).translate('Quét thành công'),
                style: TextStyle(
                    fontSize: ThemeConstant.appbar_scaffold_font_title,
                    color: ThemeConstant.appbar_text_color,
                    fontWeight: ThemeConstant.appbar_text_weight)),
            backgroundColor: ThemeConstant.appbar_background_color,
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(
                Icons.close,
                color: ThemeConstant.appbar_icon_color,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )),
        body: SafeArea(
            child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: BoxesContainer(child: Center())),
            SliverToBoxAdapter(
                child: BoxesContainer(
                    child: Padding(
                        padding: EdgeInsets.all(this._padding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              _coupon.title,
                              style: TextStyle(
                                  fontSize: ThemeConstant.boxes_font_title,
                                  letterSpacing: 0.38,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 12),
                            BaseWidget.dividerBottom,
                            SizedBox(height: 40),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  BaseWidget.avatar(
                                      _user.avatar, _user.gender, 100.0),
                                  SizedBox(height: 15),
                                  Text(
                                    _user.fullname,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        letterSpacing: 0.29,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 60.0)
                                ],
                              ),
                            ),
                            buttonBottom,
                            progressToolkit
                          ],
                        )))),
          ],
        )));
  }
}
