import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class CupertinoLocalizationsVi implements CupertinoLocalizations {
  final materialDelegate = GlobalMaterialLocalizations.delegate;
  final widgetsDelegate = GlobalWidgetsLocalizations.delegate;
  final local = const Locale('vi');

  MaterialLocalizations ml;

  Future init() async {
    ml = await materialDelegate.load(local);
  }

  @override
  String get alertDialogLabel => ml.alertDialogLabel;

  // TODO: implement anteMeridiemAbbreviation
  @override
  String get anteMeridiemAbbreviation => ml.anteMeridiemAbbreviation;

  // TODO: implement copyButtonLabel
  @override
  String get copyButtonLabel => ml.copyButtonLabel;

  // TODO: implement cutButtonLabel
  @override
  String get cutButtonLabel => ml.cutButtonLabel;

  // TODO: implement datePickerDateOrder
  @override
  DatePickerDateOrder get datePickerDateOrder => DatePickerDateOrder.mdy;

  // TODO: implement datePickerDateTimeOrder
  @override
  DatePickerDateTimeOrder get datePickerDateTimeOrder => DatePickerDateTimeOrder.date_time_dayPeriod;

  @override
  String datePickerDayOfMonth(int dayIndex) {
    return dayIndex.toString();
  }

  @override
  String datePickerHour(int hour) {
    return hour.toString().padLeft(2, "0");
  }

  @override
  String datePickerHourSemanticsLabel(int hour) => hour.toString() + " o'clock";

  @override
  String datePickerMediumDate(DateTime date) {
    return ml.formatMediumDate(date);
  }

  @override
  String datePickerMinute(int minute) {
    return minute.toString().padLeft(2, '0');
  }

  @override
  String datePickerMinuteSemanticsLabel(int minute) {
    if (minute == 1)
      return '1 minute';
    return minute.toString() + ' minutes';
  }

  @override
  String datePickerMonth(int monthIndex) {
    return "$monthIndex";
  }

  @override
  String datePickerYear(int yearIndex) {
    return yearIndex.toString();
  }

  // TODO: implement pasteButtonLabel
  @override
  String get pasteButtonLabel => ml.pasteButtonLabel;

  // TODO: implement postMeridiemAbbreviation
  @override
  String get postMeridiemAbbreviation => ml.postMeridiemAbbreviation;

  // TODO: implement selectAllButtonLabel
  @override
  String get selectAllButtonLabel => ml.selectAllButtonLabel;

  @override
  String timerPickerHour(int hour) {
    return hour.toString().padLeft(2, "0");
  }

  @override
  String timerPickerHourLabel(int hour) => hour == 1 ? 'hour' : 'hours';

  @override
  String timerPickerMinute(int minute) {
    return minute.toString().padLeft(2, "0");
  }

  @override
  String timerPickerMinuteLabel(int minute) => 'min';

  @override
  String timerPickerSecond(int second) {
    return second.toString().padLeft(2, "0");
  }

   @override
  String timerPickerSecondLabel(int second) => 'sec';

  static const LocalizationsDelegate<CupertinoLocalizations> delegate = _VietnamDelegate();

  static Future<CupertinoLocalizations> load(Locale locale) async {
    var localizaltions = CupertinoLocalizationsVi();
    await localizaltions.init();
    return SynchronousFuture<CupertinoLocalizations>(localizaltions);
  }

  @override
  // TODO: implement todayLabel
  String get todayLabel => null;
}

class _VietnamDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  const _VietnamDelegate();

  @override
  bool isSupported(Locale locale) {
    return locale.languageCode == 'vi';
  }

  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    return CupertinoLocalizationsVi.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<CupertinoLocalizations> old) {
    return false;
  }
}