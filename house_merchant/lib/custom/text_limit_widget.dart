/*
Using for textfield single and multiline
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextLimitWidget extends StatelessWidget {

  TextStyle style;
  String text;
  int maxLines = 1;
  TextOverflow overflow = TextOverflow.clip;
  TextAlign textAlign;

  TextLimitWidget(this.text, {
    this.maxLines = 1,
    this.style,
    this.overflow,
    this.textAlign = TextAlign.left
  });
  
  @override
  Widget build(BuildContext context) {

    return Flexible(
      child: new Container(
        child: new Text(
          text,
          textAlign: this.textAlign,
          overflow: TextOverflow.ellipsis,
          maxLines: this.maxLines,
          style: this.style,
        ),
      ),
    );
  }
}
