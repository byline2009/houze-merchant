/*
Using for textfield single and multiline
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:house_merchant/constant/theme_constant.dart';

typedef void CallBackHandler(String value);
typedef VoidFunc = void Function();

class TextFieldWidgetController {
  TextEditingController _controller = new TextEditingController();
  VoidFunc _callbackRefresh;

  TextFieldWidgetController() {}

  void Refresh() {
    if (_callbackRefresh != null) {
      _callbackRefresh();
    }
  }

  TextEditingController get Controller {
    return this._controller;
  }

  set Controller(TextEditingController _controller) {
    this._controller = _controller;
  }
}

class TextFieldWidget extends StatelessWidget {
  String defaultHintText;
  bool isChanged = false;
  bool enabled = false;
  TextInputType keyboardType;
  CallBackHandler callback;
  TextFieldWidgetController controller;
  final StreamController<String> _textStreamController =
      new StreamController<String>.broadcast();

  TextFieldWidget(
      {this.controller,
      this.defaultHintText,
      this.keyboardType = TextInputType.text,
      this.callback,
      this.enabled = true}) {
    //Init controller
    this.controller._callbackRefresh = () {
      this.controller.Controller.clear();
      _textStreamController.sink.add("");
    };
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _textStreamController.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
              padding: EdgeInsets.only(left: 0, right: 0),
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.all(Radius.circular(4.0)),
              //     color: Colors.white,
              //     border: Border.all(
              //         color: this.controller.Controller.text != ""
              //             ? ThemeConstant.form_border_changed
              //             : ThemeConstant.form_border_normal,
              //         width: ThemeConstant.form_border_width,
              //         style: BorderStyle.solid)),
              child: new TextField(
                cursorColor: ThemeConstant.alto_color,
                controller: this.controller.Controller,
                keyboardType: keyboardType,
                textAlign: TextAlign.left,
                onTap: () {},
                enabled: this.enabled,
                maxLines: keyboardType == TextInputType.multiline ? 5 : 1,
                style: TextStyle(
                  color: ThemeConstant.normal_color,
                  fontFamily: ThemeConstant.form_font_family,
                  fontSize: ThemeConstant.form_font_normal,
                ),
                decoration:
                    ThemeConstant.tfInputDecoration(this.defaultHintText),
//             onChanged: (String value) {
// //              if (_textController.text.length != "") {
// //                _textStreamController.sink.add(_textController.text);
// //              }
//             },
                onChanged: this.callback,
              ));
        });
  }
}
