import 'package:flutter/material.dart';
import 'package:house_merchant/constant/theme_constant.dart';

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
          padding: new EdgeInsets.all(15.0),
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
}
