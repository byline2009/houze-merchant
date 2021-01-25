/*
Using for textfield single and multiline
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextWidget extends StatelessWidget {
  final StreamController<String> controller;

  final TextStyle style;
  final String text;
  final int maxLines;

  TextWidget(
    this.text, {
    this.controller,
    this.maxLines = 1,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: controller.stream,
        initialData: text,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Text(snapshot.data,
              style: this.style,
              maxLines: this.maxLines ?? 1,
              overflow: TextOverflow.ellipsis);
        });
  }
}
