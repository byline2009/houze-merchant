import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:house_merchant/constant/theme_constant.dart';

typedef void CallBackHandler();

class ButtonSubmitEvent {
  bool isActive;

  ButtonSubmitEvent(bool value) {
    this.isActive = value;
  }
}

class ButtonWidget extends StatefulWidget {
  String defaultHintText;
  bool isActive = false;
  StreamController<ButtonSubmitEvent> controller;
  CallBackHandler callback;

  ButtonWidget({
    this.defaultHintText,
    this.isActive = false,
    this.callback,
    this.controller,
  });

  ButtonWidgetState createState() => ButtonWidgetState();
}

class ButtonWidgetState extends State<ButtonWidget> {
  ButtonWidgetState();

  Widget initButton() {
    return Container(
        decoration: widget.isActive == true
            ? const BoxDecoration(
                color: Colors.red,
                borderRadius: ThemeConstant.button_radius,
                gradient: LinearGradient(colors: <Color>[
                  ThemeConstant.button_gradient_color_right,
                  ThemeConstant.button_gradient_color_left,
                ]),
              )
            : const BoxDecoration(
                color: ThemeConstant.button_disable_color,
                borderRadius: ThemeConstant.button_radius,
              ),
        child: Padding(
            padding: const EdgeInsets.only(right: 5.0, left: 5.0),
            child: FlatButton(
                shape: ThemeConstant.formButtonBorder,
                onPressed: !widget.isActive ? null : widget.callback,
                child: Text(widget.defaultHintText,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                        letterSpacing: 0.29)))));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isActive == true && widget.controller == null)
      return initButton();

    if (widget.controller == null)
      widget.controller = new StreamController<ButtonSubmitEvent>();

    return StreamBuilder(
        stream: widget.controller.stream,
        initialData: ButtonSubmitEvent(widget.isActive),
        builder:
            (BuildContext context, AsyncSnapshot<ButtonSubmitEvent> snapshot) {
          widget.isActive = snapshot.data.isActive;

          return initButton();
        });
  }
}
