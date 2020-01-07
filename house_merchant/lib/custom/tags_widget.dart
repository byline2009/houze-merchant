import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:house_merchant/constant/theme_constant.dart';

class TagsWidget extends StatefulWidget {

  String text;
  bool isDisable;

  TagsWidget({this.text, this.isDisable});

  TagsWidgetState createState() => TagsWidgetState();
}

class TagsWidgetState extends State<TagsWidget> {

  @override
  Widget build(BuildContext context) {

    return widget.isDisable == true ? Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: ThemeConstant.background_grey_color,
          borderRadius: BorderRadius.all(Radius.circular(4.0))
        ),
        child: Center(child: Text(widget.text, style: TextStyle(
          color: Color(0xffd0d0d0),
          fontFamily: ThemeConstant.form_font_family_display,
          fontSize: ThemeConstant.form_font_title,
          fontWeight: ThemeConstant.appbar_text_weight))),
      ) : Container(
      height: 40,
      width: 40,
      decoration: ThemeConstant.borderFull,
      child: Center(child: Text(widget.text, style: TextStyle(
        color: ThemeConstant.black_color,
        fontFamily: ThemeConstant.form_font_family_display,
        fontSize: ThemeConstant.form_font_title,
        fontWeight: ThemeConstant.appbar_text_weight))),
    );
   
  }
}
