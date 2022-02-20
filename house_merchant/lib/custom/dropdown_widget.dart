// ignore_for_file: must_be_immutable

/*
  Widget by T7G, author: p.nguyen
*/

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/middle/model/keyvalue_model.dart';
import 'package:house_merchant/utils/localizations_util.dart';

typedef VoidFunc = void Function();
typedef Int2VoidFunc = void Function(int);

class DropdownWidgetController {
  FixedExtentScrollController _controller = new FixedExtentScrollController();
  VoidFunc? _callbackRefresh;

  void refresh() {
    if (_callbackRefresh != null) {
      _callbackRefresh!();
    }
  }

  FixedExtentScrollController get controller {
    return this._controller;
  }

  set controller(FixedExtentScrollController _controller) {
    this._controller = _controller;
  }
}

class DropdownWidget extends StatefulWidget {
  String titleSheet = "";
  String? labelText;
  String? defaultHintText;
  int initIndex;
  bool centerText;
  Function? buildChild;
  Function? customDialog;
  List<dynamic>? dataSource = [];
  Int2VoidFunc? doneEvent;
  Int2VoidFunc? cancelEvent;
  DropdownWidgetController? controller;

  DropdownWidget(
      {this.controller,
      this.labelText,
      this.defaultHintText,
      this.dataSource,
      this.buildChild,
      this.customDialog,
      this.titleSheet = "",
      this.initIndex = -1,
      this.centerText = false,
      required this.doneEvent,
      this.cancelEvent});

  _DropdownWidgetState createState() => _DropdownWidgetState(
      labelText: this.labelText ?? '',
      defaultHintText: this.defaultHintText!,
      dataSource: this.dataSource!,
      buildChild: this.buildChild!,
      titleSheet: this.titleSheet,
      doneEvent: this.doneEvent!,
      cancelEvent: this.cancelEvent,
      controller: this.controller!,
      centerText: this.centerText,
      initIndex: this.initIndex);
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String titleSheet = "";
  String? labelText;
  String? defaultHintText;
  int selectedIndex = -1;
  int initIndex;
  List<dynamic>? dataSource = [];
  Function? buildChild;
  Int2VoidFunc doneEvent;
  Int2VoidFunc? cancelEvent;
  bool centerText;
  final _dropdownController = TextEditingController();

  DropdownWidgetController? controller;
  StreamController<int> _dropdownStreamController =
      new StreamController<int>.broadcast();

  var _kPickerSheetHeight = 250.0;
  final double _kPickerTitleHeight = 44.0;

  _DropdownWidgetState(
      {this.controller,
      this.labelText,
      this.defaultHintText,
      this.dataSource,
      this.buildChild,
      this.titleSheet = "",
      this.initIndex = -1,
      this.centerText = false,
      required this.doneEvent,
      required this.cancelEvent}) {
    //Init controller
    this.controller!._callbackRefresh = () {
      this.selectedIndex = -1;
      this.controller!.controller = FixedExtentScrollController();
      _dropdownController.clear();
      _dropdownStreamController.sink.add(-1);
    };

    if (this.initIndex > -1 && dataSource!.length > 0) {
      this.selectedIndex = this.initIndex;
      controller!.controller =
          FixedExtentScrollController(initialItem: this.selectedIndex);
      _dropdownController.text = dataSource![this.selectedIndex].value;
      // print("=======");
      // print(this.selectedIndex);
      // print(_dropdownController.text);
      this.onComplete();
    }
  }

  void onCompleteNoRefreshDataSource() {
    controller!.controller =
        FixedExtentScrollController(initialItem: this.selectedIndex);
    _dropdownController.text = dataSource![this.selectedIndex].value;
    _dropdownStreamController.sink.add(this.selectedIndex);
  }

  void onComplete() {
    this.onCompleteNoRefreshDataSource();
    if (doneEvent != null) {
      doneEvent(this.selectedIndex);
    }
  }

  void setValue(KeyValueModel value) {
    _dropdownController.text = value.value!;
  }

  Widget _buildBottomPicker(BuildContext context, Widget picker) {
    //Default select item
    if (this.selectedIndex == -1) this.selectedIndex = 0;

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
                            if (cancelEvent != null) {
                              this.selectedIndex = -1;
                              controller!.controller =
                                  FixedExtentScrollController();
                              _dropdownController.clear();
                              _dropdownStreamController.sink.add(-1);
                              cancelEvent!(this.selectedIndex);
                            }
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: _kPickerTitleHeight,
                        child: Text(
                          this.titleSheet,
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
                            if (doneEvent != null) {
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
    final _screenSize = MediaQuery.of(context).size;
    _kPickerSheetHeight = _screenSize.height * 40 / 100;

    return StreamBuilder(
        stream: _dropdownStreamController.stream,
        initialData: -1,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //print("draw ${snapshot.data}");

          return GestureDetector(
              onTap: () async {
                if (dataSource!.length == 0) return;

                if (buildChild != null) {
                  await showCupertinoModalPopup<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return _buildBottomPicker(
                            context,
                            CupertinoPicker(
                              scrollController: controller!.controller,
                              itemExtent: _kPickerTitleHeight,
                              backgroundColor: CupertinoColors.white,
                              onSelectedItemChanged: (int index) {
                                this.selectedIndex = index;
                              },
                              children: List<Widget>.generate(
                                  dataSource!.length, (int index) {
                                return buildChild!(index);
                              }),
                            ));
                      });
                } else {
                  widget.customDialog!(this);
                }
              },
              child: Container(
                  padding: EdgeInsets.only(left: 20, right: 10),
                  decoration: BoxDecoration(
                      boxShadow: [
                        new BoxShadow(
                          color: Color(0xffd2d4d6),
                          offset: new Offset(0, 2.0),
                          blurRadius: 0.5,
                        )
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.white,
                      border: Border.all(
                          color: _dropdownController.text != ""
                              ? ThemeConstant.form_border_changed
                              : ThemeConstant.form_border_normal,
                          width: ThemeConstant.form_border_width,
                          style: BorderStyle.solid)),
                  child: Row(children: [
                    Flexible(
                        child: TextField(
                      controller: _dropdownController,
                      textAlign: this.centerText == true
                          ? TextAlign.center
                          : TextAlign.left,
                      enabled: false,
                      style: TextStyle(
                        color: ThemeConstant.normal_color,
                        fontFamily: ThemeConstant.form_font_family,
                        fontSize: ThemeConstant.form_font_normal,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: this.defaultHintText,
                        hintStyle: TextStyle(
                            color: ThemeConstant.form_text_normal,
                            fontFamily: ThemeConstant.form_font_family,
                            fontSize:
                                ThemeConstant.form_font_normal), //Text olor
                      ),
                    )),
                    Icon(
                      Icons.expand_more,
                      color: _dropdownController.text != ""
                          ? ThemeConstant.form_border_changed
                          : Colors.black,
                      size: 25.0,
                    ),
                  ])));
        });
  }

  @override
  void dispose() {
    _dropdownStreamController.close();
    super.dispose();
  }
}
