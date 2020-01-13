import 'package:flutter/material.dart';

class ThemeConstant {
  static const Color appbar_background_color = Colors.white;
  static const Color appbar_text_color = Colors.black;
  static const Color appbar_popup_color = Color(0xfff5f7f8);
  static const FontWeight appbar_text_weight = FontWeight.w500;
  static const FontWeight appbar_text_weight_bold = FontWeight.bold;
  static const FontWeight fontWeightBold = FontWeight.bold;

  static const Color appbar_icon_color = Colors.black;
  static const double appbar_font_title = 27.0;
  static const double appbar_letter_spacing = 0.43;
  static const double appbar_scaffold_font_title = 16.0;
  static const double sub_title_letter_spacing = 0.29;

//font
  static const double font_size_16 = 16.0;
  static const double font_size_24 = 24.0;
  static const double letter_spacing_038 = 0.38;
  static const double letter_spacing_026 = 0.26;
  static const double letter_spacing_024 = 0.24;

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

  //Form Theme
  static const double form_border_width = 0.7;
  static const Color form_text_normal = Color(0xff808080);
  static const Color form_hint_text = Color(0xffb5b5b5);
  static const Color form_border_changed = ThemeConstant.black_color;
  static const Color status_ok = Color(0xff38d6ac);
  static const Color status_cancel = Color(0xffff6666);
  static const Color form_border_normal = Color(0xffdcdcdc);
  static const Color form_border_small = Color(0xffdcdcdc);
  static RoundedRectangleBorder formButtonMiniBorder =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0));
  static RoundedRectangleBorder formButtonBorder =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0));
  static RoundedRectangleBorder formButtonBorderMini = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(14.0),
  );
  static const BorderRadius formButtonBorder_right = BorderRadius.only(
      topLeft: Radius.circular(25.0), bottomLeft: Radius.circular(25.0));

  static const double form_font_normal = 14.0;
  static const double form_font_small = 12.0;
  static const double form_font_smaller = 13.0;
  static const double label_font_size = 15.0;
  static const double form_font_title = 16.0;
  static const double sub_header_size = 18.0;
  static const double boxes_font_title = 24.0;
  static const double comment_font_smaller = 12.0;
  static const String form_font_family = 'SFProText';
  static const String form_font_family_display = 'SFProDisplay';

  static TextStyle subtitleStyle(Color color) {
    return TextStyle(
        fontSize: form_font_smaller,
        fontWeight: appbar_text_weight,
        letterSpacing: 0.26,
        color: color);
  }

  //Text Style
  static TextStyle headerTitleBoldStyle(Color color) {
    return TextStyle(
        fontSize: sub_header_size,
        fontWeight: appbar_text_weight_bold,
        letterSpacing: sub_title_letter_spacing,
        color: color);
  }

  static TextStyle titleStyle(Color color) {
    return TextStyle(
        fontSize: appbar_scaffold_font_title,
        fontWeight: appbar_text_weight,
        letterSpacing: 0.26,
        color: color);
  }

  //Shadow border
  static BoxDecoration shadowBottom = BoxDecoration(
    border: Border(
        bottom: BorderSide(
            color: ThemeConstant.background_grey_color,
            width: 5,
            style: BorderStyle.solid)),
  );

  static BoxDecoration decorationGreyBottom(double width) {
    return BoxDecoration(
      border: Border(
          bottom: BorderSide(
              color: ThemeConstant.background_grey_color,
              width: width,
              style: BorderStyle.solid)),
    );
  }

  static BoxDecoration borderBottom = BoxDecoration(
    color: Colors.white,
    border: Border(
        bottom: BorderSide(
            color: ThemeConstant.background_grey_color,
            width: 10,
            style: BorderStyle.solid)),
  );

  static BoxDecoration borderSmallBottom = BoxDecoration(
    color: Colors.white,
    border: Border(
        bottom: BorderSide(
            color: ThemeConstant.background_grey_color,
            width: 1,
            style: BorderStyle.solid)),
  );

  static BoxDecoration borderTopbottom = BoxDecoration(
    color: Colors.white,
    border: Border(
        top: BorderSide(
            color: ThemeConstant.background_grey_color,
            width: 10,
            style: BorderStyle.solid),
        bottom: BorderSide(
            color: ThemeConstant.background_grey_color,
            width: 10,
            style: BorderStyle.solid)),
  );

  static BoxDecoration borderFull = BoxDecoration(
      border: Border.all(
        color: ThemeConstant.black_color,
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)));

  static BoxDecoration borderOutline(Color color) {
    return BoxDecoration(
        border: Border.all(
          color: color,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)));
  }

  static BoxDecoration borderCircleNoti = BoxDecoration(
      color: ThemeConstant.form_border_error,
      border: Border.all(
        color: ThemeConstant.white_color,
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(5.0)));

  static BoxDecoration borderShadowFull = BoxDecoration(
    border: Border.fromBorderSide(BorderSide(
        color: ThemeConstant.background_grey_color,
        width: 5,
        style: BorderStyle.solid)),
  );

  static const Color listview_selected_color = Color(0xfff2e8ff);

  static const Color form_border_error = Color(0xffc50000);
  static const BorderRadius button_radius =
      BorderRadius.all(Radius.circular(5.0));
  static const BorderRadius button_radius_normal =
      BorderRadius.all(Radius.circular(10.0));
  static const Color button_disable_color = Color(0xffbdbdbd);
  static const Color button_gradient_color_right = ThemeConstant.primary_color;
  static const Color button_gradient_color_left = ThemeConstant.primary_color;

  //Colors
  static const Color link_color = ThemeConstant.primary_color;
  static const Color normal_color = Color(0xff333333);
  static const Color black_color = Color(0xff000000);
  static const Color white_color = Color(0xffffffff);
  static const Color grey_color = Color(0xff838383);
  static const Color required_color = Color(0xffc50000);

  //Login
  static const Color violet_color = Color(0xff5b00e4);
  static const Color alto_color = Color(0xffd0d0d0);
  static const Color start_yelow_color = Color(0xffffcc44);

  static const Color expired_color = Color(0xffb5b5b5);
  static const Color ready_color = Color(0xff00aa7d);
  static const Color pending_color = Color(0xffe3a500);

  static const String expired_status = 'Hết hạn';
  static const String ready_status = 'Đang chạy';
  static const String pending_status = 'Chờ duyệt';
}
