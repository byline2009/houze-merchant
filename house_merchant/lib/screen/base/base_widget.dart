import 'package:flutter/material.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:flutter_svg/flutter_svg.dart';

const double horizontalPadding = 20.0;
typedef void CallBackHandler();

class BaseWidget {
  static Widget note(Widget text, {Color color}) {
    return Container(
      width: double.infinity,
      padding: new EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: color == null ? Color(0xfff5f7f8) : color,
        borderRadius: new BorderRadius.all(Radius.circular(10.0)),
      ),
      child: text,
    );
  }

  static Container dividerBottom = Container(
    height: 2.0,
    color: ThemeConstant.form_border_normal,
  );

  static Widget buttonThemePink(String text,
      {Color color, CallBackHandler callback}) {
    return GestureDetector(
        onTap: () {
          if (callback != null) {
            callback();
          }
        },
        child: Container(
          width: double.infinity,
          padding: new EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: color == null ? Color(0xfff2e8ff) : color,
            borderRadius: new BorderRadius.all(Radius.circular(4.0)),
          ),
          child: Text(
            text,
            style: TextStyle(
              letterSpacing: 0.29,
              fontFamily: ThemeConstant.form_font_family_display,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ThemeConstant.primary_color,
            ),
            textAlign: TextAlign.center,
          ),
        ));
  }

  static Widget buttonOutline(String text,
      {Color color, CallBackHandler callback}) {
    return GestureDetector(
        onTap: () {
          if (callback != null) {
            callback();
          }
        },
        child: Container(
          width: double.infinity,
          padding: new EdgeInsets.all(12.0),
          decoration:
              ThemeConstant.borderOutline(ThemeConstant.form_border_error),
          child: Text(
            text,
            style: TextStyle(
              letterSpacing: 0.29,
              fontFamily: ThemeConstant.form_font_family_display,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ThemeConstant.form_border_error,
            ),
            textAlign: TextAlign.center,
          ),
        ));
  }

  static Widget avatar(String url, String gender, double height) {
    return Container(
        height: height,
        width: height,
        decoration: BoxDecoration(
            borderRadius: new BorderRadius.circular(height / 2),
            border: Border.all(
                color: Colors.white, width: 3, style: BorderStyle.solid)),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            RawMaterialButton(
              child: ClipRRect(
                  borderRadius: new BorderRadius.circular(height / 2),
                  child: Stack(overflow: Overflow.clip, children: <Widget>[
                    Container(
                        color: Colors.white,
                        child: url != null
                            ? Image.network(url, fit: BoxFit.cover)
                            : SvgPicture.asset(
                                "assets/images/gender/avt-O.svg"))
                  ])),
              onPressed: () {
                print("select avatar");
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
          ],
        ));
  }
}
