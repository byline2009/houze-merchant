/*
Using for textfield single and multiline
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextWidget extends StatelessWidget {

  StreamController<String> controller = new StreamController<String>.broadcast();

  TextStyle style;
  String text;
  int maxLines = 1;
  bool softWrap = false;
  TextOverflow overflow = TextOverflow.clip;

  TextWidget(this.text, {
    this.controller,
    this.maxLines = 1,
    this.softWrap = true,
    this.style,
    this.overflow,
  });
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: controller.stream,
      initialData: text,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Text(
          snapshot.data,
          style: this.style,
          maxLines: this.maxLines,
          overflow: TextOverflow.ellipsis,
        );
      });
  }
}
