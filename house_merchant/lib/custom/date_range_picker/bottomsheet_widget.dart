// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:house_merchant/utils/localizations_util.dart';

typedef Int2VoidFunc = void Function(int);

class BottomSheetWidget extends StatefulWidget {
  String title;
  Widget child;
  Int2VoidFunc doneEvent;
  Int2VoidFunc cancelEvent;

  BottomSheetWidget(
      {this.title, this.child, @required this.doneEvent, this.cancelEvent});

  @override
  BottomSheetWidgetState createState() => BottomSheetWidgetState();
}

class BottomSheetWidgetState extends State<BottomSheetWidget> {
  var _kPickerSheetHeight = 250.0;
  final double _kPickerTitleHeight = 44.0;
  int selectedIndex = -1;

  void onComplete() {
    if (widget.doneEvent != null) {
      widget.doneEvent(this.selectedIndex);
    }
  }

  Widget _buildBottomPicker(BuildContext context, Widget picker) {
    final _screenSize = MediaQuery.of(context).size;
    _kPickerSheetHeight = _screenSize.height * 40 / 100;

    return Container(
      height: _kPickerSheetHeight,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 22.0,
        ),
        child: SafeArea(
          top: false,
          child: Column(
            children: <Widget>[
              // Title Action
              Container(
                  height: _kPickerTitleHeight,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: _kPickerTitleHeight,
                        child: TextButton(
                          child: Text(
                            LocalizationsUtil.of(context).translate('Hủy'),
                            style: TextStyle(
                              color: Theme.of(context).unselectedWidgetColor,
                              fontSize: 16.0,
                            ),
                          ),
                          onPressed: () {
                            if (widget.cancelEvent != null) {
                              this.selectedIndex = -1;
                              widget.cancelEvent(this.selectedIndex);
                            }
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: _kPickerTitleHeight,
                        child: Text(
                          widget.title != null ? widget.title : '',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Container(
                        height: _kPickerTitleHeight,
                        child: TextButton(
                          child: Text(
                            LocalizationsUtil.of(context).translate('Hoàn tất'),
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16.0,
                            ),
                          ),
                          onPressed: () {
                            if (widget.doneEvent != null) {
                              this.onComplete();
                            }
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  )),
              // Content data source
              Flexible(child: picker),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBottomPicker(context, widget.child);
  }
}
