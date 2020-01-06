import 'package:flutter/material.dart';

class ThemeConstant {
  static const Color appbar_background_color = Colors.white;
  static const Color appbar_text_color = Colors.black;
  static const Color appbar_popup_color = Color(0xfff5f7f8);
  static const FontWeight appbar_text_weight = FontWeight.w500;
  static const FontWeight appbar_text_weight_bold = FontWeight.bold;
  static const Color appbar_icon_color = Colors.black;
  static const double appbar_font_title = 27.0;

  //background
  static const Color background_grey_color = Color(0xfff5f5f5);
  static const Color background_white_color = Color(0xffffffff);
  static const Color border_color = Color(0xff979797);

  static const Color primary_color = Color(0xff7a1dff);
  static const Color unselected_color = Color(0xffb5b5b5);

  //Status color
  static const Color status_pending = Color(0xffff9b00);
  static const Color status_approved = Color(0xff00aa7d);
  static const Color status_rejected = Color(0xffff6666);
  static const Color status_canceled = Color(0xff808080);

  static const Color promotion_status_pending = Color(0xffd68100);
  static const Color promotion_status_running = Color(0xff00aa7d);
  static const Color promotion_status_expired = Color(0xffb5b5b5);

  static const double form_font_normal = 14.0;
  static const double form_font_small = 12.0;
  static const double form_font_smaller = 13.0;
  static const double label_font_size = 15.0;
  static const double form_font_title = 16.0;
  static const double sub_header_size = 18.0;
  static const double comment_font_smaller = 12.0;
  static const String form_font_family = 'SFProText';
  static const String form_font_family_display = 'SFProDisplay';

  static const Color listview_selected_color = Color(0xfff2e8ff);

  static const Color form_border_small = Color(0xffdcdcdc);
  static const BorderRadius button_radius =
      BorderRadius.all(Radius.circular(5.0));
  static const BorderRadius button_radius_normal =
      BorderRadius.all(Radius.circular(10.0));

  //Colors
  static const Color link_color = ThemeConstant.primary_color;
  static const Color normal_color = Color(0xff333333);
  static const Color black_color = Color(0xff000000);
  static const Color white_color = Color(0xffffffff);
  static const Color grey_color = Color(0xff838383);

  //Login
  static const Color violet_color = Color(0xff5b00e4);
  static const Color alto_color = Color(0xffd0d0d0);
}
