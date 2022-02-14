// ignore_for_file: must_be_immutable

/*
Using for textfield single and multiline
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:house_merchant/constant/theme_constant.dart';

typedef void CallBackHandler(String value);
typedef VoidFunc = void Function();

class TextFieldWidgetController {
  TextEditingController _controller = TextEditingController();
  VoidFunc _callbackRefresh;

  TextFieldWidgetController();

  get text {
    return _controller.text;
  }

  set text(String text) {
    _controller.text = text;
  }

  void refresh() {
    if (_callbackRefresh != null) {
      _callbackRefresh();
    }
  }

  TextEditingController get controller {
    return this._controller;
  }

  set controller(TextEditingController _controller) {
    this._controller = _controller;
  }
}

class TextFieldWidget extends StatelessWidget {
  String defaultHintText;
  bool isChanged = false;
  bool enabled = false;
  bool obscureText = false;
  TextInputType keyboardType;
  CallBackHandler callback;
  TextFieldWidgetController controller;
  // ignore: close_sinks
  final StreamController<String> textStreamController =
      StreamController<String>.broadcast();
  VoidFunc onTap;

  TextFieldWidget(
      {this.controller,
      this.defaultHintText,
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      this.callback,
      this.onTap,
      this.enabled = true}) {
    //Init controller
    this.controller._callbackRefresh = () {
      this.controller.controller.clear();
      textStreamController.sink.add("");
    };
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: textStreamController.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
//          Container(
//            padding: EdgeInsets.only(left: 10, right: 10),
//            decoration: BoxDecoration(
//                borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                color: Colors.white,
//                border: Border.all(
//                    color: this.controller.controller.text != "" ? ThemeConstant.form_border_changed : ThemeConstant.form_border_normal,
//                    width: ThemeConstant.form_border_width,
//                    style: BorderStyle.solid)
//            ),

          return TextField(
            cursorColor: ThemeConstant.alto_color,
            obscureText: this.obscureText,
            controller: this.controller.controller,
            keyboardType: keyboardType,
            textAlign: TextAlign.left,
            onTap: () {
              if (this.onTap != null) {
                this.onTap();
              }
            },
            enabled: this.enabled,
            maxLines: keyboardType == TextInputType.multiline ? 5 : 1,
            style: TextStyle(
              color: ThemeConstant.normal_color,
              fontFamily: ThemeConstant.form_font_family,
              fontSize: ThemeConstant.form_font_normal,
            ),
            decoration: InputDecoration(
              hintText: this.defaultHintText,
              contentPadding: EdgeInsets.only(left: 10, right: 10, top: 20),
              border: InputBorder.none,
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(
                    color: this.controller.controller.text != ""
                        ? ThemeConstant.form_border_changed
                        : ThemeConstant.form_border_normal),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(
                    color: this.controller.controller.text != ""
                        ? ThemeConstant.form_border_changed
                        : ThemeConstant.form_border_normal),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: ThemeConstant.primary_color),
              ),
            ),
            onChanged: this.callback,
          );
        });
  }
}
