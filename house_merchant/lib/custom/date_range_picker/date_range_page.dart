import 'package:flutter/material.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/utils/localizations_util.dart';
import 'package:house_merchant/custom/date_range_picker/date_range_picker.dart'
    as DateRagePicker;

class DateRangePage extends StatefulWidget {
  final dynamic callback;
  final List<DateTime?>? data;

  DateRangePage({this.callback, this.data, Key? key}) : super(key: key);

  @override
  DateRangePageState createState() => DateRangePageState();
}

class DateRangePageState extends State<DateRangePage> {
  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var initialFirstDate = now;
    var initialLastDate = now;
    if (widget.data != null && widget.data!.length > 0) {
      initialFirstDate = widget.data![0]!;
      initialLastDate = widget.data![1]!;
    }

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => {Navigator.pop(context)},
              icon: Icon(Icons.arrow_back,
                  color: Colors.black87)), // appbar leading icon.
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
              initialFirstDate: initialFirstDate,
              initialLastDate: initialLastDate,
              firstDate: new DateTime(initialFirstDate.year),
              lastDate: new DateTime(initialLastDate.year + 1),
            )));
  }
}
