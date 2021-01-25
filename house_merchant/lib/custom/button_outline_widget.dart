import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/button_widget.dart';

class ButtonOutlineWidget extends StatefulWidget {
  final String defaultHintText;
  bool isActive = false;
  StreamController<ButtonSubmitEvent> controller;
  final CallBackHandler callback;

  ButtonOutlineWidget({
    this.defaultHintText,
    this.isActive = false,
    this.callback,
    this.controller,
  });

  ButtonOutlineWidgetState createState() => ButtonOutlineWidgetState();
}

class ButtonOutlineWidgetState extends State<ButtonOutlineWidget> {
  ButtonOutlineWidgetState();

  Widget initButton() {
    return Container(
        width: double.infinity,
        decoration: widget.isActive == true
            ? ThemeConstant.borderOutline(ThemeConstant.primary_color)
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
                        color: ThemeConstant.primary_color,
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
