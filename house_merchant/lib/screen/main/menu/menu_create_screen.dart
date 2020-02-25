import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/screen/base/base_scaffold_normal.dart';
import 'package:house_merchant/screen/base/base_widget.dart';
import 'package:house_merchant/utils/localizations_util.dart';
import 'package:house_merchant/utils/progresshub.dart';

class MenuCreateScreen extends StatefulWidget {
  MenuCreateScreen({Key key}) : super(key: key);

  @override
  MenuCreateScreenState createState() => new MenuCreateScreenState();
}

class MenuCreateScreenState extends State<MenuCreateScreen> {
  ProgressHUD progressToolkit = Progress.instanceCreate();
  Size _screenSize;

  Widget showSucessful() {
    final width = this._screenSize.width * 90 / 100;
    return Padding(
        padding: EdgeInsets.all(15),
        child: Container(
            width: width,
            child: Column(
              children: <Widget>[
                SvgPicture.asset(
                  "assets/images/dialogs/graphic-voucher.svg",
                ),
                Text(
                    LocalizationsUtil.of(context)
                        .translate('Tạo sản phẩm thành công!'),
                    style: ThemeConstant.titleLargeStyle(Colors.black)),
                SizedBox(height: 20),
                Center(
                    child: Text(
                  LocalizationsUtil.of(context).translate(
                      'Chúc cửa hàng của bạn kinh doanh\nthành công tốt đẹp nhé!'),
                  style: TextStyle(
                      color: ThemeConstant.grey_color,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.26),
                  textAlign: TextAlign.center,
                )),
                SizedBox(height: 50),
                BaseWidget.buttonThemePink('Về trang chính', callback: () {
                  Navigator.of(context).popUntil((route) {
                    return route.isFirst;
                  });
                })
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldNormal(
      child: showSucessful(),
    );
  }
}
