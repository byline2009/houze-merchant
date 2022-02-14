// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:house_merchant/constant/theme_constant.dart';

class BoxesContainer extends StatelessWidget {
  Widget child;
  String title;
  EdgeInsets padding;
  Widget action;
  bool noLine = false;

  BoxesContainer(
      {@required this.child,
      this.title,
      this.action,
      this.padding,
      this.noLine = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: this.noLine == false
            ? ThemeConstant.borderBottom
            : BoxDecoration(
                color: Colors.white,
              ),
        padding: this.padding != null ? this.padding : EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                this.title != null
                    ? Text(this.title,
                        style: TextStyle(
                            color: ThemeConstant.black_color,
                            fontFamily: ThemeConstant.form_font_family_display,
                            fontSize: ThemeConstant.boxes_font_title,
                            fontWeight: ThemeConstant.appbar_text_weight_bold))
                    : Center(),
                this.action != null ? this.action : Center()
              ],
            ),
            child
          ],
        ));
  }
}
