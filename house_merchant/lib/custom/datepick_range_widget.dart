/*
Using for textfield single and multiline
 */
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:house_merchant/custom/date_range_picker/date_range_page.dart';
import 'package:house_merchant/custom/textfield_widget.dart';
import 'package:intl/intl.dart';

typedef void CallBackHandler(String value);
typedef VoidFunc = void Function();

class DateRangePickerWidget extends StatefulWidget {

  String defaultHintText;
  bool isActive = false;
  int index = 0;
  StreamController<List<DateTime>> controller;
  CallBackHandler callback;

  DateRangePickerWidget({
    this.controller,
    this.index,
    this.defaultHintText,
    this.callback
  });

  DateRangePickerWidgetState createState() => DateRangePickerWidgetState();

}

class DateRangePickerWidgetState extends State<DateRangePickerWidget> {

  DateTime now;
  TextFieldWidgetController localController = new TextFieldWidgetController();

  DateRangePickerWidgetState() {
    this.now = new DateTime.now();
  }

  @override
  Widget build(BuildContext context) {

     return StreamBuilder(
      stream: widget.controller.stream,
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot<List<DateTime>> snapshot) {

        if (snapshot.data!=null && snapshot.data.length > 0) {
          localController.Controller.text = DateFormat('HH:mm - dd/MM/yyyy').format(snapshot.data[widget.index]);
        }

        if (snapshot.data!=null && snapshot.data.length == 0) {
          localController.Controller.clear();
        }

        return GestureDetector(
          onTap: () async {
            final dateRangePage = DateRangePage();
            List<DateTime> result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
              return dateRangePage;
            }, settings: RouteSettings(name: "app://DateRangePage"), fullscreenDialog: true));
            widget.controller.sink.add(result);
          },
          child: TextFieldWidget(controller: localController, defaultHintText: widget.defaultHintText, enabled: false,)
        );
      }
    );
  }
}
