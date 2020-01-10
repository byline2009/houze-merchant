import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:house_merchant/constant/theme_constant.dart';

class RectangleLabelWidget extends StatefulWidget {
  String text;
  Color color;

  RectangleLabelWidget({this.text, this.color});

  RectangleLabelWidgetState createState() => RectangleLabelWidgetState();
}

class RectangleLabelWidgetState extends State<RectangleLabelWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: Center(
          child: Text(widget.text.toUpperCase(),
              style: TextStyle(
                  letterSpacing: ThemeConstant.letter_spacing_026,
                  color: ThemeConstant.white_color,
                  fontSize: ThemeConstant.form_font_smaller,
                  fontWeight: FontWeight.w600))),
    );
  }
}
