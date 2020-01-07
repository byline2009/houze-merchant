/*
Using for textfield single and multiline
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:house_merchant/custom/date_range_picker/date_range_page.dart';
import 'package:house_merchant/custom/textfield_widget.dart';

typedef void CallBackHandler(String value);
typedef VoidFunc = void Function();

class DateRangePickerWidgetController {
  TextEditingController _controller = new TextEditingController();
  VoidFunc _callbackRefresh;

  DateRangePickerWidgetController();

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

class DateRangePickerWidget extends StatelessWidget {

  String defaultHintText;
  bool isChanged = false;
  TextInputType keyboardType;
  CallBackHandler callback;
  TextFieldWidgetController controller;
  final StreamController<String> _textStreamController = new StreamController<String>.broadcast();
  DateTime now;

  DateRangePickerWidget({
    this.controller,
    this.defaultHintText,
    this.keyboardType = TextInputType.text,
    this.callback
  }) {
    this.now = new DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final dateRangePage = DateRangePage(callback: callback,);
        List<DateTime> result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
          return dateRangePage;
        }, settings: RouteSettings(name: "app://DateRangePage"), fullscreenDialog: true));
        print(result);
        //this.callback();
      },
      child: TextFieldWidget(controller: this.controller, defaultHintText: this.defaultHintText, enabled: false,)
    );
  }
}
