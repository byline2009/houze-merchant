import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/button_widget.dart';
import 'package:house_merchant/custom/dropdown_widget.dart';
import 'package:house_merchant/custom/multi_select_chip_widget.dart';
import 'package:house_merchant/middle/model/keyvalue_model.dart';
import 'package:house_merchant/screen/base/base_scaffold_normal.dart';
import 'package:house_merchant/utils/localizations_util.dart';
import 'package:house_merchant/utils/progresshub.dart';

class StoreEditTimeScreen extends StatefulWidget {
  dynamic params;
  StoreEditTimeScreen({Key key, this.params}) : super(key: key);

  @override
  StoreEditTimeScreenState createState() => new StoreEditTimeScreenState();
}

class StoreEditTimeScreenState extends State<StoreEditTimeScreen> {
  Size _screenSize;
  BuildContext _context;
  double _padding;
  StreamController<ButtonSubmitEvent> saveButtonController =
      new StreamController<ButtonSubmitEvent>.broadcast();
  ProgressHUD _progressToolkit = Progress.instanceCreate();

  final _fOpeningHours = DropdownWidgetController();
  final _fCloseHours = DropdownWidgetController();
  final _dataSourceHours = [];
  final _dataSourceWorkingDay = [];
  List _selectedWorkingDayList = List();

  int _initOpeningHourIndex = 0;
  int _initCloseHourIndex = 0;

  dynamic params;

  @override
  void initState() {
    super.initState();
    //Init dataSourceYear
    var times = [
      "7:00",
      "7:30",
      "8:00",
      "8:30",
      "9:00",
      "9:30",
      "10:00",
      "10:30",
      "11:00",
      "11:30",
      "12:00",
      "12:30",
      "13:00",
      "13:30",
      "14:00",
      "14:30",
      "15:00",
      "15:30",
      "16:00",
      "16:30",
      "17:00",
      "17:30",
      "18:00",
      "18:30",
      "19:00",
      "19:30",
      "20:00",
      "20:30",
      "21:00",
      "21:30",
      "22:00",
      "22:30"
    ];
    for (var i = 0; i < times.length; i++) {
      _dataSourceHours.add(KeyValueModel(key: i, value: times[i]));
    }
    print(_dataSourceHours.length);
    _initOpeningHourIndex = _dataSourceHours.first.key;
    _initCloseHourIndex = _dataSourceHours.last.key;

    var workingDays = ["T2", "T3", "T4", "T5", "T6", "T7", "CN"];
    for (var i = 0; i < workingDays.length; i++) {
      _dataSourceWorkingDay.add(KeyValueModel(key: i, value: workingDays[i]));
    }
  }

  bool checkValidation() {
    var isActive = false;
    if (_initOpeningHourIndex < _initCloseHourIndex) {
      isActive = true;
    }
    saveButtonController.sink.add(ButtonSubmitEvent(isActive));
    return isActive;
  }

  Widget buildBody() {
    Widget _titleSection(String title) {
      return Row(
        children: <Widget>[
          Text('*',
              style: TextStyle(
                fontFamily: ThemeConstant.form_font_family_display,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: ThemeConstant.required_color,
              )),
          SizedBox(width: 5),
          Text(LocalizationsUtil.of(context).translate(title),
              style: TextStyle(
                fontFamily: ThemeConstant.form_font_family_display,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.26,
                color: ThemeConstant.grey_color,
              ))
        ],
      );
    }

    Widget workingDaySection() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ChoiceChipsWidget(
            _dataSourceWorkingDay,
            onSelectionChanged: (selectedList) {
              setState(() {
                _selectedWorkingDayList = selectedList;
                print(_selectedWorkingDayList);
              });
            },
          ),
        ],
      );
    }

    Widget timeSection(String title, String content) {
      return Container(
          child: Column(
        children: <Widget>[
          _titleSection(title),
          SizedBox(height: 10),
          DropdownWidget(
              controller: _fOpeningHours,
              labelText: title,
              defaultHintText:
                  LocalizationsUtil.of(context).translate('Chọn giờ'),
              dataSource: _dataSourceHours,
              centerText: true,
              buildChild: (index) {
                return Center(
                    child: Text(
                  "${_dataSourceHours[index].value}",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      letterSpacing: ThemeConstant.letter_spacing_026,
                      fontWeight: FontWeight.w500),
                ));
              },
              initIndex: _initOpeningHourIndex,
              doneEvent: (index) async {
                print({"$title": _dataSourceHours[index].key});
              })
        ],
      ));
    }

    return Positioned(
        right: 0.0,
        left: 0,
        bottom: 0,
        top: 10.0,
        child: Container(
          decoration: BoxDecoration(color: ThemeConstant.white_color),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Thời gian',
                style: ThemeConstant.titleLargeStyle(Colors.black),
              ),
              SizedBox(height: 30),
              _titleSection('Chọn ngày làm việc'),
              SizedBox(height: 10),
              workingDaySection(),
              SizedBox(height: 30),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: ((_screenSize.width - (_padding * 2)) / 2) - 10,
                      child: Container(
                          child: Column(
                        children: <Widget>[
                          _titleSection("Giờ mở cửa"),
                          SizedBox(height: 10),
                          DropdownWidget(
                              controller: _fOpeningHours,
                              defaultHintText: LocalizationsUtil.of(context)
                                  .translate('Chọn giờ'),
                              dataSource: _dataSourceHours,
                              centerText: true,
                              buildChild: (index) {
                                return Center(
                                    child: Text(
                                  "${_dataSourceHours[index].value}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      letterSpacing:
                                          ThemeConstant.letter_spacing_026,
                                      fontWeight: FontWeight.w500),
                                ));
                              },
                              initIndex: _initOpeningHourIndex,
                              doneEvent: (index) async {
                                _initOpeningHourIndex = index;
                                this.checkValidation();
                                print(_dataSourceHours[index].key);
                              })
                        ],
                      )),
                    ),
                    Container(
                      width: ((_screenSize.width - (_padding * 2)) / 2) - 10,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            _titleSection("Giờ đóng cửa"),
                            SizedBox(height: 10),
                            DropdownWidget(
                                controller: _fCloseHours,
                                defaultHintText: LocalizationsUtil.of(context)
                                    .translate('Chọn giờ'),
                                dataSource: _dataSourceHours,
                                centerText: true,
                                buildChild: (index) {
                                  return Center(
                                      child: Text(
                                    "${_dataSourceHours[index].value}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        letterSpacing:
                                            ThemeConstant.letter_spacing_026,
                                        fontWeight: FontWeight.w500),
                                  ));
                                },
                                initIndex: _initCloseHourIndex,
                                doneEvent: (index) async {
                                  _initCloseHourIndex = index;
                                  this.checkValidation();
                                  print(_dataSourceHours[index].value);
                                })
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          padding: EdgeInsets.all(_padding),
        ));
  }

  @override
  Widget build(BuildContext context) {
    this._screenSize = MediaQuery.of(context).size;
    this._context = context;
    this._padding = this._screenSize.width * 5 / 100;

    final saveChangeButton = Positioned(
      bottom: 20.0,
      left: 20.0,
      right: 20.0,
      child: ButtonWidget(
          controller: saveButtonController,
          defaultHintText:
              LocalizationsUtil.of(_context).translate('Lưu thay đổi'),
          callback: () async {}),
    );

    // TODO: implement build
    return BaseScaffoldNormal(
        title: 'Chỉnh sửa cửa hàng',
        child: SafeArea(
            child: Stack(children: <Widget>[
          Container(
            decoration:
                BoxDecoration(color: ThemeConstant.background_grey_color),
          ),
          buildBody(),
          saveChangeButton
        ])));
  }
}

class MyThreeOptions extends StatefulWidget {
  @override
  _MyThreeOptionsState createState() => _MyThreeOptionsState();
}

class _MyThreeOptionsState extends State<MyThreeOptions> {
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List<Widget>.generate(
        3,
        (int index) {
          return ChoiceChip(
            label: Text('Item $index'),
            selected: _value == index,
            onSelected: (bool selected) {
              setState(() {
                _value = selected ? index : null;
              });
            },
          );
        },
      ).toList(),
    );
  }
}
