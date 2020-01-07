import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/utils/localizations_util.dart';

class BaseScaffold extends StatelessWidget {
  final Widget child;
  final Widget bottom;
  final String title;
  final Widget trailing;
  final Color backgroundColor;

  BaseScaffold(
      {this.title,
      this.child,
      this.bottom,
      this.trailing,
      this.backgroundColor});

  Widget notificationBoxLeading() {
    return Stack(
      children: <Widget>[
        Container(
          height: 100.0,
          padding: EdgeInsets.only(left: 20.0),
          child: IconButton(
            icon: SvgPicture.asset(
              "assets/icons/ic-notification.svg",
              width: 20.0,
              height: 24.0,
              fit: BoxFit.contain,
            ),
            onPressed: () {
              print('Noti clicked');
            },
          ),
        ),
        Positioned(
          top: 12.0,
          right: 6.0,
          child: Container(
              width: 10.0,
              height: 10.0,
              decoration: ThemeConstant.borderCircleNoti),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: <Widget>[
        SizedBox(height: 20),
        AppBar(
          titleSpacing: 20.0,
          centerTitle: false,
          leading: notificationBoxLeading(),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                this.trailing != null ? this.trailing : Center()
              ],
            ),
          ],
          title: Text(LocalizationsUtil.of(context).translate(this.title),
              style: TextStyle(
                  letterSpacing: ThemeConstant.appbar_letter_spacing,
                  fontSize: ThemeConstant.appbar_font_title,
                  color: ThemeConstant.appbar_text_color,
                  fontWeight: ThemeConstant.appbar_text_weight_bold)),
          backgroundColor: this.backgroundColor != null
              ? this.backgroundColor
              : ThemeConstant.appbar_background_color,
          elevation: 0.0,
        ),
        this.bottom != null ? this.bottom : Center(),
        Expanded(child: child)
      ],
    ));
  }
}
