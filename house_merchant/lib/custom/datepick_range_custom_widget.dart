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

class DateRangePickerCustomWidget extends StatefulWidget {
  String? defaultHintText;
  bool isActive = false;
  StreamController<List<DateTime>>? controller;
  CallBackHandler? callback;
  DateTime? firstDate;
  DateTime? lastDate;

  DateRangePickerCustomWidget(
      {this.firstDate,
      this.lastDate,
      this.controller,
      this.defaultHintText,
      this.callback});

  DateRangePickerCustomWidgetState createState() =>
      DateRangePickerCustomWidgetState();
}

class DateRangePickerCustomWidgetState
    extends State<DateRangePickerCustomWidget> {
  DateTime? now;
  final localController = TextFieldWidgetController();

  DateRangePickerCustomWidgetState();

  @override
  void initState() {
    super.initState();

    localController.controller.text =
        DateFormat(Format.timeAndDate).format(widget.firstDate!) +
            ' đến ' +
            DateFormat(Format.timeAndDate).format(widget.lastDate!);
    print(localController);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.controller!.stream,
        builder:
            (BuildContext context, AsyncSnapshot<List<DateTime>> snapshot) {
          if (snapshot.data != null && snapshot.data!.length > 0) {
            localController.controller.text =
                DateFormat(Format.timeAndDate).format(snapshot.data!.first) +
                    ' đến ' +
                    DateFormat(Format.timeAndDate).format(snapshot.data!.last);
            widget.firstDate = snapshot.data!.first;
            widget.lastDate = snapshot.data!.last;
          }

          return GestureDetector(
              onTap: () async {
                final dateRangePage =
                    DateRangePage(data: [widget.firstDate, widget.lastDate]);
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
                      enabled: false)));
        });
  }
}
