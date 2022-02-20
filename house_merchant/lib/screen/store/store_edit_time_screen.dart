import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/button_widget.dart';
import 'package:house_merchant/custom/dropdown_widget.dart';
import 'package:house_merchant/custom/multi_select_chip_widget.dart';
import 'package:house_merchant/custom/text_widget.dart';
import 'package:house_merchant/middle/model/keyvalue_model.dart';
import 'package:house_merchant/middle/model/shop_model.dart';
import 'package:house_merchant/middle/repository/shop_repository.dart';
import 'package:house_merchant/screen/base/base_scaffold_normal.dart';
import 'package:house_merchant/screen/base/boxes_container.dart';
import 'package:house_merchant/screen/main/store_screen.dart';
import 'package:house_merchant/utils/localizations_util.dart';
import 'package:house_merchant/utils/progresshub.dart';

class StoreEditTimeScreen extends StatefulWidget {
  final StoreEditArgument? params;
  StoreEditTimeScreen({Key? key, this.params}) : super(key: key);

  @override
  StoreEditTimeScreenState createState() => StoreEditTimeScreenState();
}

class StoreEditTimeScreenState extends State<StoreEditTimeScreen> {
  Size? _screenSize;
  BuildContext? _context;
  double? _padding;
  final StreamController<ButtonSubmitEvent> saveButtonController =
      StreamController<ButtonSubmitEvent>.broadcast();
  ProgressHUD _progressToolkit = Progress.instanceCreate();

  final StreamController<String> messageText =
      StreamController<String>.broadcast();
  final _fOpeningHours = DropdownWidgetController();
  final _fCloseHours = DropdownWidgetController();
  final _dataSourceHours = [];
  final _dataSourceWorkingDay = [];
  List<int?> _selectedWorkingDayList = <int?>[];
  var messageError = "";

  ShopRepository shopRepository = ShopRepository();
  //Model
  var openTime, closeTime = "";
  ShopModel? _shopModel;

  int _initOpeningHourIndex = 0;
  int _initCloseHourIndex = 0;

  dynamic params;

  @override
  void dispose() {
    _fCloseHours.controller.dispose();
    _fOpeningHours.controller.dispose();
    messageText.close();
    saveButtonController.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    this._shopModel = widget.params!.shopModel;
    this._selectedWorkingDayList =
        this._shopModel!.hours!.map((f) => f.weekday).toList();
    //Init dataSourceYear
    var times = [
      "00:00",
      "00:30",
      "01:00",
      "01:30",
      "02:00",
      "02:30",
      "03:00",
      "03:30",
      "04:00",
      "04:30",
      "05:00",
      "05:30",
      "06:00",
      "06:30",
      "07:00",
      "07:30",
      "08:00",
      "08:30",
      "09:00",
      "09:30",
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
      "22:30",
      "23:00",
      "23:30",
    ];
    for (var i = 0; i < times.length; i++) {
      _dataSourceHours.add(KeyValueModel(key: i, value: times[i]));
    }

    _initOpeningHourIndex = _dataSourceHours.first.key;
    _initCloseHourIndex = _dataSourceHours.last.key;
    if (this._shopModel!.hours != null && this._shopModel!.hours!.length > 0) {
      _initOpeningHourIndex = times
          .indexWhere((time) => time == this._shopModel!.hours![0].startTime);
      _initCloseHourIndex = times
          .indexWhere((time) => time == this._shopModel!.hours![0].endTime);
    }

    var workingDays = ["T2", "T3", "T4", "T5", "T6", "T7", "CN"];
    for (var i = 0; i < workingDays.length; i++) {
      _dataSourceWorkingDay.add(KeyValueModel(key: i, value: workingDays[i]));
    }
  }

  bool checkValidation() {
    checkHourValidate();
    var isActive = false;
    if (_initOpeningHourIndex < _initCloseHourIndex &&
        _selectedWorkingDayList.length > 0) {
      isActive = true;
    }
    saveButtonController.sink.add(ButtonSubmitEvent(isActive));
    return isActive;
  }

  void checkHourValidate() {
    String str = '';
    if (_selectedWorkingDayList.length == 0) {
      str = 'Bạn chưa chọn ngày làm việc!';
    }

    if ((_initOpeningHourIndex < _initCloseHourIndex) == false &&
        _selectedWorkingDayList.length <= 0) {
      str = '';
    }

    if ((_initOpeningHourIndex < _initCloseHourIndex) == false) {
      str = 'Giờ đóng cửa phải lớn hơn giờ mở cửa!';
    }

    messageError = str;
    messageText.sink.add(messageError);
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
                  color: ThemeConstant.required_color)),
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
      return Container(
          height: 50.0,
          child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ChoiceChipsWidget(
                  _dataSourceWorkingDay,
                  selectedChoices: _selectedWorkingDayList,
                  onSelectionChanged: (selectedList) {
                    _selectedWorkingDayList = selectedList;
                    this.checkValidation();
                    this._shopModel!.hours = _selectedWorkingDayList
                        .map((f) => Hours(
                              startTime: openTime,
                              endTime: closeTime,
                              weekday: f,
                            ))
                        .toList();
                  },
                ),
              ],
            )
          ]));
    }

    return Container(
        padding: EdgeInsets.all(this._padding!),
        decoration: BoxDecoration(color: ThemeConstant.white_color),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Thời gian',
                  style: ThemeConstant.titleLargeStyle(Colors.black)),
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
                    Expanded(
                        child: Container(
                            child: Column(children: <Widget>[
                      _titleSection("Giờ mở cửa"),
                      SizedBox(height: 10),
                      DropdownWidget(
                          controller: _fOpeningHours,
                          defaultHintText: LocalizationsUtil.of(context)
                              .translate('Chọn giờ'),
                          dataSource: _dataSourceHours,
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
                            openTime = _dataSourceHours[index].value;
                          })
                    ]))),
                    SizedBox(width: 15),
                    Expanded(
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
                                  closeTime = _dataSourceHours[index].value;
                                })
                          ],
                        ),
                      ),
                    )
                  ])),
              SizedBox(height: 20),
              TextWidget(
                '',
                controller: messageText,
                style:
                    ThemeConstant.subtitleStyle(ThemeConstant.required_color),
              ),
            ]));
  }

  Widget saveChangeButton() {
    return ButtonWidget(
        controller: saveButtonController,
        defaultHintText:
            LocalizationsUtil.of(_context!).translate('Lưu thay đổi'),
        callback: () async {
          _progressToolkit.state.show();

          if (this.checkValidation()) {
            try {
              //Reupdate hours
              this._shopModel!.hours = _selectedWorkingDayList
                  .map((f) => Hours(
                        startTime: openTime,
                        endTime: closeTime,
                        weekday: f,
                      ))
                  .toList();

              await shopRepository
                  .updateInfo(this._shopModel!)
                  .then((value) => widget.params!.callback!(value));
              _progressToolkit.state.dismiss();
              Fluttertoast.showToast(
                  msg: 'Cập nhật thời gian thành công',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 14.0);
            } catch (e) {
              _progressToolkit.state.dismiss();
              Fluttertoast.showToast(
                  msg: e.toString(),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 14.0);
            } finally {
              saveButtonController.sink.add(ButtonSubmitEvent(false));
              _progressToolkit.state.dismiss();
            }
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    this._screenSize = MediaQuery.of(context).size;
    this._context = context;
    this._padding = this._screenSize!.width * 5 / 100;

    return Stack(children: <Widget>[
      BaseScaffoldNormal(
        title: 'Chỉnh sửa cửa hàng',
        child: SafeArea(
            child: Container(
                color: ThemeConstant.background_white_color,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    BoxesContainer(child: Center()),
                    Expanded(child: buildBody()),
                    Padding(
                      child: saveChangeButton(),
                      padding: EdgeInsets.all(_padding!),
                    ),
                  ],
                ))),
      ),
      _progressToolkit
    ]);
  }
}
