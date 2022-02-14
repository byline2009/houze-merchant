// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/textfield_widget.dart';

class TextFieldStyle1Widget extends TextFieldWidget {
  String defaultHintText;
  bool isChanged = false;
  bool enabled = false;
  TextInputType keyboardType;
  CallBackHandler callback;
  TextFieldWidgetController controller;

  TextFieldStyle1Widget(
      {this.controller,
      this.defaultHintText,
      this.keyboardType = TextInputType.text,
      this.callback,
      this.enabled = true})
      : super(
          controller: controller,
          defaultHintText: defaultHintText,
          callback: callback,
          enabled: enabled,
        );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: super.textStreamController.stream,
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
                controller: this.controller.controller,
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
