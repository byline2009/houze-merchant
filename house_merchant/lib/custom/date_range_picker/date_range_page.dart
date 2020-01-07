import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/utils/localizations_util.dart';
import 'package:house_merchant/custom/date_range_picker/date_range_picker.dart' as DateRagePicker;

class DateRangePage extends StatefulWidget {

  dynamic callback;

  DateRangePage({this.callback, Key key}) : super(key: key);

  @override
  DateRangePageState createState() => DateRangePageState();
}

class DateRangePageState extends State<DateRangePage> {

  @override
  Widget build(BuildContext context) {

    final now = new DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationsUtil.of(context).translate('Chọn thời gian'),
          style: TextStyle(
          fontSize: ThemeConstant.appbar_scaffold_font_title,
          color: ThemeConstant.appbar_text_color,
          fontWeight: ThemeConstant.appbar_text_weight)),
        backgroundColor: ThemeConstant.appbar_background_color,
        elevation: 0.0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: DateRagePicker.showDatePicker(
          context: context,
          initialFirstDate: now,
          initialLastDate: now,
          firstDate: new DateTime(now.year),
          lastDate: new DateTime(now.year + 1),
        ))
    );
  }
}