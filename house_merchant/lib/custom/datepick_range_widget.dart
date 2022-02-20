// ignore_for_file: must_be_immutable

/*
Using for textfield single and multiline
 */
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:house_merchant/constant/common_constant.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/date_range_picker/date_range_page.dart';
import 'package:house_merchant/custom/textfield_widget.dart';
import 'package:intl/intl.dart';

typedef void CallBackHandler(List<DateTime> value);
typedef VoidFunc = void Function();

class DateRangePickerWidget extends StatefulWidget {
  final String? defaultHintText;
  bool isActive = false;
  StreamController<List<DateTime>>? controller;
  final CallBackHandler? callback;

  DateRangePickerWidget({this.controller, this.defaultHintText, this.callback});

  DateRangePickerWidgetState createState() => DateRangePickerWidgetState();
}

class DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  DateTime? now;
  List<DateTime?>? localDate;
  TextFieldWidgetController localController = new TextFieldWidgetController();

  DateRangePickerWidgetState() {
    this.now = new DateTime.now();
    this.localDate = [now, now];
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.controller!.stream,
        builder:
            (BuildContext context, AsyncSnapshot<List<DateTime>> snapshot) {
          if (snapshot.data != null && snapshot.data!.length > 0) {
            localController.controller.text =
                DateFormat(Format.timeAndDate).format(snapshot.data![0]) +
                    ' đến ' +
                    DateFormat(Format.timeAndDate).format(snapshot.data![1]);
            this.localDate = snapshot.data;
          }

          if (snapshot.data != null && snapshot.data!.length == 0) {
            localController.controller.clear();
            this.localDate = [];
          }

          return GestureDetector(
              onTap: () async {
                final dateRangePage = DateRangePage(data: this.localDate);
                List<DateTime> result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) {
                          return dateRangePage;
                        },
                        settings: RouteSettings(name: "app://DateRangePage"),
                        fullscreenDialog: true));
                widget.controller!.sink.add(result);
                widget.callback!(result);
              },
              child: Container(
                  color: ThemeConstant.white_color,
                  child: TextFieldWidget(
                    controller: localController,
                    defaultHintText: widget.defaultHintText!,
                    enabled: false,
                  )));
        });
  }
}
