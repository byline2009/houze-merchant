import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/button_widget.dart';
import 'package:house_merchant/middle/model/qrcode_model.dart';
import 'package:house_merchant/middle/repository/coupon_repository.dart';
import 'package:house_merchant/screen/base/base_scaffold_normal.dart';
import 'package:house_merchant/screen/base/base_widget.dart';
import 'package:house_merchant/screen/base/boxes_container.dart';
import 'package:house_merchant/utils/localizations_util.dart';
import 'package:house_merchant/utils/progresshub.dart';

class PromotionScanSuccessScreen extends StatefulWidget {
  dynamic params;
  PromotionScanSuccessScreen({this.params, key}) : super(key: key);

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
          if (widget.params['callback'] != null) {
            var model = widget.params['qr_code_model'] as QrCodeModel;
            widget.params['callback'](model);
          }
          Navigator.of(context).pop();
          Fluttertoast.showToast(
              msg: 'Xác nhận sử dụng mã thành công!',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 5,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 14.0);
        }
      } catch (e) {
        Fluttertoast.showToast(
            msg: e.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 5,
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

    // TODO: implement build
    return BaseScaffoldNormal(
        title: 'Quét thành công',
        child: SafeArea(
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
